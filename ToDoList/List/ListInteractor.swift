import Foundation

protocol ListInteractorProtocol {
    func loadFromAPI()
    func loadFromCoreData()
    func getTodos() -> [Todo]
    func removeTodo(forIndex: Int)
    func updateStateOfTodo(id: UUID)
}

final class ListInteractor {
    weak var presenter: ListPresenterProtocol?
    private var todos: [Todo]?
}

extension ListInteractor: ListInteractorProtocol {
    
    func getTodos() -> [Todo] {
        guard let todos = todos else { return [] }
        return todos
    }
    
    func removeTodo(forIndex: Int) {
        guard let todo = todos?[forIndex].id else { return }
        CoreDataManager.shared.deletaTodo(with: todo)
        todos?.remove(at: forIndex)
    }
    
    func updateStateOfTodo(id: UUID) {
        DispatchQueue.main.async { [self] in
            guard let index = todos?.firstIndex(where: { $0.id == id}) else { return }
            todos?[index].isCompleted.toggle()
            guard let todo = todos?[index] else { return }
            CoreDataManager.shared.updataTodo(todo: todo)
        }
    }
    
    func loadFromAPI() {
        NetworkManager.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todos):
                    self?.todos = todos
                    self?.presenter?.didLoad()
                    todos.forEach { todo in
                        CoreDataManager.shared.createTodo(todo: todo)
                    }
                case .failure(let failure):
                    fatalError("Fail:\(failure)")
                    break
                }
            }
        }
    }
    
    func loadFromCoreData() {
        var todos = [Todo]()
        CoreDataManager.shared.fetchTodos().forEach { todo in
            let todo = Todo(
                id: todo.id,
                header: todo.header,
                todo: todo.text ?? "",
                completed: todo.isCompleted,
                date: todo.date ?? ""
            )
            todos.append(todo)
        }
        self.todos = todos
        self.presenter?.didLoad()
    }
    
}

extension ListInteractor: TaskInteractoreDelegate {
    
    func saveTodo(todo: Todo) {
        todos?.append(todo)
        presenter?.didLoad()
    }
    
    func updateTodo(todo: Todo) {
        guard let index = todos?.firstIndex(where: { $0.id == todo.id }) else { return }
        todos?[index] = todo
        presenter?.didLoad()
    }
    
}

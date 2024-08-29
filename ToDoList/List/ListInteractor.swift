import Foundation

protocol ListInteractorProtocol {
    func loadFromAPI()
    func loadFromCoreData()
    func getTasks() -> [Todo]
    func removeTask(forIndex: Int)
    func updateStateOfTask(id: UUID)
}

class ListInteractor {
    weak var presenter: ListPresenterProtocol?
    private var tasks: [Todo]?
}

extension ListInteractor: ListInteractorProtocol {
    
    func getTasks() -> [Todo] {
        guard let tasks = tasks else { return [] }
        return tasks
    }
    
    func removeTask(forIndex: Int) {
        guard let task = tasks?[forIndex].id else { return }
        CoreDataManager.shared.deletaTask(with: task)
        tasks?.remove(at: forIndex)
    }
    
    func updateStateOfTask(id: UUID) {
        DispatchQueue.main.async { [self] in
            guard let index = tasks?.firstIndex(where: { $0.id == id}) else { return }
            tasks?[index].isCompleted.toggle()
            guard let task = tasks?[index] else { return }
            CoreDataManager.shared.updataTask(todo: task)
        }
    }
    
    func loadFromAPI() {
        NetworkManager.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todos):
                    self?.tasks = todos
                    self?.presenter?.didLoad()
                    todos.forEach { task in
                        CoreDataManager.shared.createTask(todo: task)
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
        CoreDataManager.shared.fetchTasks().forEach { task in
            let todo = Todo(
                id: task.id,
                header: task.header,
                todo: task.text ?? "",
                completed: task.isCompleted,
                date: task.date ?? ""
            )
            todos.append(todo)
        }
        self.tasks = todos
        self.presenter?.didLoad()
    }
    
}

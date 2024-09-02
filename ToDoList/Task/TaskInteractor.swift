import Foundation

protocol TaskInteractorProtocol {
    func getTodo() -> (Todo, Bool)
    func saveTodo(todo: Todo)
    func updateTodo(todo: Todo)
}

protocol TaskInteractoreDelegate: AnyObject {
    func saveTodo(todo: Todo)
    func updateTodo(todo: Todo)
}

final class TaskInteractor {
    
    weak var presenter: TaskPresenterProtocol?
    weak var delegate: TaskInteractoreDelegate?
    
    private let todo: Todo
    private let newTodo: Bool
    
    init(presenter: TaskPresenterProtocol? = nil, todo: Todo, newTodo: Bool) {
        self.presenter = presenter
        self.todo = todo
        self.newTodo = newTodo
    }
    
}

extension TaskInteractor: TaskInteractorProtocol {
    
    func saveTodo(todo: Todo) {
        CoreDataManager.shared.createTodo(todo: todo)
        delegate?.saveTodo(todo: todo)
    }
    
    func updateTodo(todo: Todo) {
        CoreDataManager.shared.updataTodo(todo: todo)
        delegate?.updateTodo(todo: todo)
    }
    
    func getTodo() -> (Todo, Bool)  {
        (todo, newTodo)
    }
    
}

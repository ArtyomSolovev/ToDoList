import Foundation

protocol TaskInteractorProtocol {
    func getTask() -> (Todo, Bool)
    func saveTask(task: Todo)
    func updateTask(task: Todo)
}

protocol TaskInteractoreDelegate: AnyObject {
    func saveTask(task: Todo)
    func updateTask(task: Todo)
}

class TaskInteractor {
    
    weak var presenter: TaskPresenterProtocol?
    weak var delegate: TaskInteractoreDelegate?
    
    let todo: Todo
    let newTask: Bool
    
    init(presenter: TaskPresenterProtocol? = nil, todo: Todo, newTask: Bool) {
        self.presenter = presenter
        self.todo = todo
        self.newTask = newTask
    }
    
}

extension TaskInteractor: TaskInteractorProtocol {
    
    func saveTask(task: Todo) {
        CoreDataManager.shared.createTask(todo: task)
        delegate?.saveTask(task: task)
    }
    
    func updateTask(task: Todo) {
        CoreDataManager.shared.updataTask(todo: task)
        delegate?.updateTask(task: task)
    }
    
    func getTask() -> (Todo, Bool)  {
        (todo, newTask)
    }
    
}

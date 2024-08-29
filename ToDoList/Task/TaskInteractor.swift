import Foundation

protocol TaskInteractorProtocol {
    func getTask() -> (Todo, Bool)
    func saveTask(task: Todo)
    func updateTask(task: Todo)
}

class TaskInteractor {
    
    weak var presenter: TaskPresenterProtocol?
    
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
    }
    
    func updateTask(task: Todo) {
        CoreDataManager.shared.updataTask(todo: task)
    }
    
    func getTask() -> (Todo, Bool)  {
        (todo, newTask)
    }
    
}

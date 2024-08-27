import Foundation

protocol TaskInteractorProtocol {
    func getTask() -> Todo
}

class TaskInteractor {
    
    weak var presenter: TaskPresenterProtocol?
    
    let todo: Todo
    
    init(presenter: TaskPresenterProtocol? = nil, todo: Todo) {
        self.presenter = presenter
        self.todo = todo
    }
    
}

extension TaskInteractor: TaskInteractorProtocol {
    
    func getTask() -> Todo {
        todo
    }
    
}

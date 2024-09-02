import Foundation

protocol TaskPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func updateTodo(todo: Todo)
    func saveTodo(todo: Todo)
}

final class TaskPresenter {
    weak var view: TaskViewProtocol?
    var router: TaskRouterProtocol
    var interactor: TaskInteractorProtocol
    
    init(router: TaskRouterProtocol, interactor: TaskInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension TaskPresenter: TaskPresenterProtocol {
    
    func updateTodo(todo: Todo) {
        interactor.updateTodo(todo: todo)
    }
    
    func saveTodo(todo: Todo) {
        interactor.saveTodo(todo: todo)
    }
    
    func viewDidLoaded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){ [self] in
            let todo = interactor.getTodo()
            view?.viewTodo(todo: todo.0, newTodo: todo.1)
        }
    }
    
}

import Foundation

protocol TaskPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func setData(data: Todo)
}

class TaskPresenter {
    weak var view: TaskViewProtocol?
    var router: TaskRouterProtocol
    var interactor: TaskInteractorProtocol
    
    init(router: TaskRouterProtocol, interactor: TaskInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension TaskPresenter: TaskPresenterProtocol {
    
    func viewDidLoaded() {
        let task = interactor.getTask()
        view?.viewTask(todo: task)
    }
    
    func setData(data: Todo) {
        view?.viewTask(todo: data)
    }
    
}

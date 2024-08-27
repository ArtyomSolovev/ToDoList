import Foundation

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(data: [Todo])
    func didTapNewTaskButton()
}

class ListPresenter {
    weak var view: ListViewProtocol?
    var router: ListRouterProtocol
    var interactor: ListInteractorProtocol
    
    init(router: ListRouterProtocol, interactor: ListInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension ListPresenter: ListPresenterProtocol {
    
    func viewDidLoaded() {
        interactor.loadToDo()
    }
    
    func didLoad(data: [Todo]) {
        view?.showData(data: data)
    }
    
    func didTapNewTaskButton() {
        let task = Todo(
            id: 0,
            todo: "",
            completed: false,
            date: Date.getCurrectDate()
        )
        router.openTask(task: task)
    }
    
}

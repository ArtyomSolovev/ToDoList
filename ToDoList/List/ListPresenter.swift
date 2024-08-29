import Foundation

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad(data: [Todo])
//    func didTapNewTaskButton()
    func openTask(task: Todo)
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
    
    func openTask(task: Todo) {
        router.openTask(task: task)
    }
    
    func viewDidLoaded() {
        interactor.loadToDo()
    }
    
    func didLoad(data: [Todo]) {
        view?.showData(data: data)
    }
    
//    func didTapNewTaskButton() {
//        let task = Todo(
//            id: 0,
//            header: "",
//            todo: "",
//            completed: false,
//            date: Date.getCurrectDate()
//        )
//        router.openTask(task: task)
//    }
    
}

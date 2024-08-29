import Foundation

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad()
    func openTask(task: Todo, newTask: Bool)
    func getTasks() -> [Todo]
    func removeTask(forIndex: Int)
    func updateStateOfTask(id: UUID)
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
    
    func getTasks() -> [Todo] {
        interactor.getTasks()
    }
    
    func removeTask(forIndex: Int) {
        interactor.removeTask(forIndex: forIndex)
    }
    
    func updateStateOfTask(id: UUID) {
        interactor.updateStateOfTask(id: id)
    }
    
    func openTask(task: Todo, newTask: Bool) {
        router.openTask(task: task, newTask: newTask)
    }
    
    func viewDidLoaded() {
        if UserDefaults.standard.bool(forKey: "notFirstStart") {
            interactor.loadFromCoreData()
        } else {
            interactor.loadFromAPI()
            UserDefaults.standard.setValue(true, forKey: "notFirstStart")
        }
    }
    
    func didLoad() {
        view?.showData()
    }
    
}

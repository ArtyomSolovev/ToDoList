import Foundation

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoad()
    func openTodo(todo: Todo, newTodo: Bool)
    func getTodos() -> [Todo]
    func removeTodo(forIndex: Int)
    func updateStateOfTodo(id: UUID)
}

final class ListPresenter {
    weak var view: ListViewProtocol?
    var router: ListRouterProtocol
    var interactor: ListInteractorProtocol
    
    init(router: ListRouterProtocol, interactor: ListInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension ListPresenter: ListPresenterProtocol {
    
    func getTodos() -> [Todo] {
        interactor.getTodos()
    }
    
    func removeTodo(forIndex: Int) {
        interactor.removeTodo(forIndex: forIndex)
    }
    
    func updateStateOfTodo(id: UUID) {
        interactor.updateStateOfTodo(id: id)
    }
    
    func openTodo(todo: Todo, newTodo: Bool) {
        guard let interactorForDelegate = interactor as? ListInteractor else { return }
        router.openTodo(todo: todo, newTodo: newTodo, forDelegate: interactorForDelegate)
    }
    
    func viewDidLoaded() {
        if UserDefaults.standard.bool(forKey: Constants.keyNotFirstStart.rawValue) {
            interactor.loadFromCoreData()
        } else {
            interactor.loadFromAPI()
            UserDefaults.standard.setValue(true, forKey: Constants.keyNotFirstStart.rawValue)
        }
    }
    
    func didLoad() {
        view?.reloadData()
    }
    
}

import Foundation

protocol TaskPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func updateData(task: Todo)
    func saveData(task: Todo)
//    func setData(data: Todo)
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
    
    func updateData(task: Todo) {
        interactor.updateTask(task: task)
    }
    
    func saveData(task: Todo) {
        interactor.saveTask(task: task)
    }
    
    
    func viewDidLoaded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){ [self] in
            let task = interactor.getTask()
            view?.viewTask(todo: task.0, newTask: task.1)
        }
    }
    
//    func setData(data: Todo) {
//        view?.viewTask(todo: data, newTask: <#Bool#>)
//    }
    
}

import Foundation

protocol ListRouterProtocol: AnyObject {
    func openTask(task: Todo, newTask: Bool, forDelegate: ListInteractor)
}

class ListRouter {
    weak var viewController: ListViewController?
}

extension ListRouter: ListRouterProtocol{
    
    func openTask(task: Todo, newTask: Bool, forDelegate: ListInteractor) {
        let taskViewController = TaskModuleBuilder.build(todo: task, newTask: newTask, forDelegate: forDelegate)
        viewController?.present(taskViewController, animated: true)
    }
    
}

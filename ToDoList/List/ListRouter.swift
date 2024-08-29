import Foundation

protocol ListRouterProtocol: AnyObject {
    func openTask(task: Todo, newTask: Bool)
}

class ListRouter {
    weak var viewController: ListViewController?
}

extension ListRouter: ListRouterProtocol{
    
    func openTask(task: Todo, newTask: Bool) {
        let taskViewController = TaskModuleBuilder.build(todo: task, newTask: newTask)
        viewController?.present(taskViewController, animated: true)
    }
    
}

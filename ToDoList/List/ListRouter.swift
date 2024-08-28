import Foundation

protocol ListRouterProtocol: AnyObject {
    func openTask(task: Todo)
}

class ListRouter {
    weak var viewController: ListViewController?
    
}

extension ListRouter: ListRouterProtocol{
    
    func openTask(task: Todo) {
        let taskViewController = TaskModuleBuilder.build(todo: task)
        viewController?.present(taskViewController, animated: true)
    }
    
}

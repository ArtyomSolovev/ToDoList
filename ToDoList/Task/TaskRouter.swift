import Foundation

protocol TaskRouterProtocol: AnyObject {
    
}

class TaskRouter {
    weak var viewController: TaskViewProtocol?
}

extension TaskRouter: TaskRouterProtocol {
    
}

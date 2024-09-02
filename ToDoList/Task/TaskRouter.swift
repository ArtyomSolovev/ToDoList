import Foundation

protocol TaskRouterProtocol: AnyObject {
    
}

final class TaskRouter {
    weak var viewController: TaskViewProtocol?
}

extension TaskRouter: TaskRouterProtocol {
    
}

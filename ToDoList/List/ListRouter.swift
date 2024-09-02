import Foundation

protocol ListRouterProtocol: AnyObject {
    func openTodo(todo: Todo, newTodo: Bool, forDelegate: ListInteractor)
}

final class ListRouter {
    weak var viewController: ListViewController?
}

extension ListRouter: ListRouterProtocol{
    
    func openTodo(todo: Todo, newTodo: Bool, forDelegate: ListInteractor) {
        let taskViewController = TaskModuleBuilder.build(todo: todo, newTodo: newTodo, forDelegate: forDelegate)
        viewController?.present(taskViewController, animated: true)
    }
    
}

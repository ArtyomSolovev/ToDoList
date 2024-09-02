import Foundation

final class TaskModuleBuilder {
    static func build(todo: Todo, newTodo: Bool, forDelegate: ListInteractor) -> TaskViewController {
        let interactor = TaskInteractor(todo: todo, newTodo: newTodo)
        let router = TaskRouter()
        let presenter = TaskPresenter(
            router: router,
            interactor: interactor
        )
        let viewController = TaskViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.delegate = forDelegate
        router.viewController = viewController
        return viewController
    }
}

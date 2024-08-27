import Foundation

class TaskModuleBuilder {
    static func build(todo: Todo) -> TaskViewController {
        let interactor = TaskInteractor(todo: todo)
        let router = TaskRouter()
        let presenter = TaskPresenter(
            router: router,
            interactor: interactor
        )
        let viewController = TaskViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}

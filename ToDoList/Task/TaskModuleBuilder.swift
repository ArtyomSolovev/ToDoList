import Foundation

class TaskModuleBuilder {
    static func build(todo: Todo, newTask: Bool) -> TaskViewController {
        let interactor = TaskInteractor(todo: todo, newTask: newTask)
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

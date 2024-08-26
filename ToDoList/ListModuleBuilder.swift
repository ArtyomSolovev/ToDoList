import Foundation

class ListModuleBuilder {
    static func build() -> ListViewController {
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter(
            router: router,
            interactor: interactor
        )
        let viewController = ListViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
        return viewController
    }
}

import Foundation

protocol ListRouterProtocol: AnyObject {
    
}

class ListRouter {
    weak var presenter: ListPresenterProtocol?
    
}

extension ListRouter: ListRouterProtocol{
    
}

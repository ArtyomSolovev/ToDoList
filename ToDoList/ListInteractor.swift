import Foundation

protocol ListInteractorProtocol {
    func loadToDo()
}

class ListInteractor {
    
    weak var presenter: ListPresenterProtocol?
    
}

extension ListInteractor: ListInteractorProtocol {
    func loadToDo() {
        NetworkManager.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todos):
                    self?.presenter?.didLoad(data: todos)
                case .failure(let failure):
                    fatalError("Fail")
                    break
                }
            }
        }
    }
    
}

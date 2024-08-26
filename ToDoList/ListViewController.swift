import UIKit

protocol ListViewProtocol: AnyObject {
    
}

class ListViewController: UIViewController {

    var presenter: ListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }

}

extension ListViewController: ListViewProtocol {
    
}

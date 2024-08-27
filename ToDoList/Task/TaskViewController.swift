import UIKit

protocol TaskViewProtocol: AnyObject {
    func viewTask(todo: Todo)
}

class TaskViewController: UIViewController {

    var presenter: TaskPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        view.backgroundColor = .white
    }

}

extension TaskViewController: TaskViewProtocol {
    
    func viewTask(todo: Todo) {
        DispatchQueue.main.async {
            print("text:\(todo)")
        }
    }
    
}

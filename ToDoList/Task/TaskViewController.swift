import UIKit

protocol TaskViewProtocol: AnyObject {
    func viewTask(todo: Todo)
}

class TaskViewController: UIViewController {

    var presenter: TaskPresenterProtocol?
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        return button
    }()
    
    private let headerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название задачи"
        textField.borderStyle = .line
        return textField
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Описание"
        textField.borderStyle = .line
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    private func setupView() {
        
        [cancelButton, saveButton, headerTextField, textField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cancelButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            saveButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            headerTextField.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10),
            headerTextField.heightAnchor.constraint(equalTo: saveButton.heightAnchor),
            headerTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            headerTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5),
            
            textField.topAnchor.constraint(equalTo: headerTextField.bottomAnchor, constant: 10),
            textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            textField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5),
            textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension TaskViewController: TaskViewProtocol {
    
    func viewTask(todo: Todo) {
        DispatchQueue.main.async {
            print("text:\(todo)")
        }
    }
    
}

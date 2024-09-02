import UIKit

protocol TaskViewProtocol: AnyObject {
    func viewTodo(todo: Todo, newTodo: Bool)
}

final class TaskViewController: UIViewController {

    var presenter: TaskPresenterProtocol?
    private var todo: Todo?
    private var isNewTodo: Bool?
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(named: Constants.textColor.rawValue), for: .normal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(UIColor(named: Constants.textColor.rawValue), for: .normal)
        return button
    }()
    
    private let headerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название задачи"
        textField.borderStyle = .line
        return textField
    }()
    
    private let textField: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        cancelButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        headerTextField.delegate = self
        textField.delegate = self
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
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            saveButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
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
    
    @objc func closeView(sender: UIButton!) {
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped(sender: UIButton!) {
        guard let isNewTodo, let idOfTodo = isNewTodo ? UUID() : todo?.id else { return }
        let todo = Todo(
            id: idOfTodo,
            header: headerTextField.text,
            todo: textField.text,
            completed: todo?.isCompleted ?? false,
            date: todo?.date ?? Date.getCurrectDate()
        )
        if isNewTodo {
            presenter?.saveTodo(todo: todo)
        } else {
            presenter?.updateTodo(todo: todo)
        }
        dismiss(animated: true)
    }
    
    private func changeStateOfSaveButton() {
        let isEnabled = !headerTextField.text!.isEmpty || !textField.text.isEmpty
        saveButton.isEnabled = isEnabled
        saveButton.alpha = isEnabled ? 1 : 0.1
    }
    
}

extension TaskViewController: TaskViewProtocol {
    
    func viewTodo(todo: Todo, newTodo: Bool) {
        DispatchQueue.main.async { [self] in
            self.todo = todo
            headerTextField.text = todo.header
            textField.text = todo.text
            self.isNewTodo = newTodo
            changeStateOfSaveButton()
        }
    }
    
}

extension TaskViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        changeStateOfSaveButton()
    }

}

extension TaskViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        changeStateOfSaveButton()
    }
    
}

import UIKit

protocol ListViewProtocol: AnyObject {
    func reloadData()
    func updateStateOfTodo(id: UUID)
}

final class ListViewController: UIViewController {
    
    var presenter: ListPresenterProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Новая задача", for: .normal)
        button.setTitleColor(UIColor(named: Constants.textColor.rawValue), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        configureTableView()
        configureButton()
        button.addTarget(self, action: #selector(createTodo), for: .touchUpInside)
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }

    private func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func configureButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            button.leftAnchor.constraint(equalTo: view.leftAnchor),
            button.rightAnchor.constraint(equalTo: view.rightAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func createTodo(sender: UIButton!) {
        let todo = Todo(
            id: UUID(),
            header: nil,
            todo: "",
            completed: false,
            date: Date.getCurrectDate()
        )
        presenter?.openTodo(todo: todo, newTodo: true)
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todos = presenter?.getTodos()
        guard let todo = todos?[indexPath.row] else { return }
        presenter?.openTodo(todo: todo, newTodo: false)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getTodos().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseId, for: indexPath) as? ListTableViewCell else { return .init() }
        let todos = presenter?.getTodos()
        guard let todo = todos?[indexPath.row] else { return cell }
        cell.setData(todo: todo, viewController: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.removeTodo(forIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension ListViewController: ListViewProtocol {
    
    func updateStateOfTodo(id: UUID) {
        presenter?.updateStateOfTodo(id: id)
        tableView.reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

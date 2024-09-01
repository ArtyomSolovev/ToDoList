import UIKit

protocol ListViewProtocol: AnyObject {
    func showData()
    func updateStateOfTask(id: UUID)
}

class ListViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Новая задача", for: .normal)
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = true
        return button
    }()

    var presenter: ListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        configureTableView()
        configureButton()
        button.addTarget(self, action: #selector(createTask), for: .touchUpInside)
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }

    func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func configureButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            button.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func createTask(sender: UIButton!) {
        let task = Todo(
            id: UUID(),
            header: nil,
            todo: "",
            completed: false,
            date: Date.getCurrectDate()
        )
        presenter?.openTask(task: task, newTask: true)
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tasks = presenter?.getTasks()
        guard let task = tasks?[indexPath.row] else { return }
        presenter?.openTask(task: task, newTask: false)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getTasks().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseId, for: indexPath) as? ListTableViewCell else { return .init() }
        let tasks = presenter?.getTasks()
        guard let task = tasks?[indexPath.row] else { return cell }
        cell.setData(task: task, viewController: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.removeTask(forIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension ListViewController: ListViewProtocol {
    
    func updateStateOfTask(id: UUID) {
        presenter?.updateStateOfTask(id: id)
        tableView.reloadData()
    }
    
    func showData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

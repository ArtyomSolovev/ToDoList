import UIKit

protocol ListViewProtocol: AnyObject {
    func showData(data: [Todo])
    func updateStateOfTask(id: Int16)
}

class ListViewController: UIViewController {
    
    var todos = [Todo]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
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
            id: Int16(todos.count),
            header: nil,
            todo: "",
            completed: false,
            date: Date.getCurrectDate()
        )
        presenter?.openTask(task: task)
//        presenter?.didTapNewTaskButton()
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openTask(task: todos[indexPath.row])
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseId, for: indexPath) as! ListTableViewCell
        let task = todos[indexPath.row]
        cell.setData(task: task, viewController: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        for index in indexPath.row..<todos.count {
            todos[index].id -= 1
        }
    }
    
}

extension ListViewController: ListViewProtocol {
    
    func updateStateOfTask(id: Int16) {
        DispatchQueue.main.async { [self] in
            guard let index = todos.firstIndex(where: { $0.id == id}) else { return }
            todos[index].isCompleted.toggle()
            tableView.reloadData()
        }
    }
    
    func showData(data: [Todo]) {
        DispatchQueue.main.async {
            self.todos = data
            self.tableView.reloadData()
        }
    }
    
}

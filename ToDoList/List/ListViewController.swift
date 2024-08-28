import UIKit

protocol ListViewProtocol: AnyObject {
    func showData(data: [Todo])
}

class ListViewController: UIViewController {
    
    var data = [Todo]()
    
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
        presenter?.didTapNewTaskButton()
    }
}

extension ListViewController: UITableViewDelegate {
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseId, for: indexPath) as! ListTableViewCell
        let task = data[indexPath.row]
        cell.setData(task: task)
        return cell
    }
    
}

extension ListViewController: ListViewProtocol {
    func showData(data: [Todo]) {
        DispatchQueue.main.async {
            self.data = data
            self.tableView.reloadData()
        }
    }
    
}

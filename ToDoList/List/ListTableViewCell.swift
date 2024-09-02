import UIKit

final class ListTableViewCell: UITableViewCell {

    static let reuseId = "ListTableViewCell"
    private var id: UUID?
    private var viewController: ListViewProtocol?
    
    private let completedMarker: UIButton = {
        let button = UIButton()
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        return button
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
         label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
         label.setContentHuggingPriority(.required, for: .horizontal)
         label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        completedMarker.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [completedMarker, headerLabel, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            completedMarker.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            completedMarker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completedMarker.widthAnchor.constraint(equalToConstant: 22),
            
            headerLabel.leftAnchor.constraint(equalTo: completedMarker.rightAnchor, constant: 5),
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dateLabel.leftAnchor.constraint(equalTo: headerLabel.rightAnchor, constant: 5),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
    
    @objc private func changeState(sender: UIButton!) {
        viewController?.updateStateOfTodo(id: id!)
    }
    
    func setData(todo: Todo, viewController: ListViewProtocol) {
        id = todo.id
        let statusOfTodo = todo.isCompleted ? "checkmark.square" : "square"
        completedMarker.setImage(UIImage(systemName: statusOfTodo), for: .normal)
        let isTodoHaveNotHeader = todo.header == "" || todo.header == nil
        headerLabel.text = isTodoHaveNotHeader ? todo.text : todo.header
        dateLabel.text = todo.date
        self.viewController = viewController
    }
    
}

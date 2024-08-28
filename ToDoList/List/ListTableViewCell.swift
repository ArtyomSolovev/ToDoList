import UIKit

final class ListTableViewCell: UITableViewCell {

    static let reuseId = "ListTableViewCell"
    
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(task: Todo) {
        let statusTask = task.completed ? "checkmark.square" : "square"
        completedMarker.setImage(UIImage(systemName: statusTask), for: .normal)
        headerLabel.text = task.todo
        dateLabel.text = task.date
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
    
//    func setTaskStatus(isDone: Bool) {
//        if isDone {
//            completedMarker.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
//        } else {
//            completedMarker.setImage(UIImage(systemName: "square"), for: .normal)
//        }
//    }
    
    
}

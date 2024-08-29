import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int16
    let header: String?
    let text: String
    var isCompleted: Bool
    let date: String?
    
    init(id: Int16, header: String?, todo: String, completed: Bool, date: String) {
        self.id = id
        self.header = header
        self.text = todo
        self.isCompleted = completed
        self.date = date
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int16.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        header = nil
        date = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case isCompleted = "completed"
        case text = "todo"
//        case userID = "userId"
    }
}

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int
    let header: String?
    let todo: String
    var completed: Bool
    let date: String?
    
    init(id: Int, header: String?, todo: String, completed: Bool, date: String) {
        self.id = id
        self.header = header
        self.todo = todo
        self.completed = completed
        self.date = date
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        todo = try container.decode(String.self, forKey: .todo)
        completed = try container.decode(Bool.self, forKey: .completed)
        header = nil
        date = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id, todo, completed
//        case userID = "userId"
    }
}

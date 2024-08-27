import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let date: String?
    
    init(id: Int, todo: String, completed: Bool, date: String) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.date = date
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        todo = try container.decode(String.self, forKey: .todo)
        completed = try container.decode(Bool.self, forKey: .completed)
        date = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id, todo, completed
//        case userID = "userId"
    }
}

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    init() {}
    
    func fetchData(completion: @escaping (Result<[Todo], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else { return }
        
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(Welcome.self, from: data)
                    var todos = [Todo]()
                    data.todos.forEach{ todos.append(
                        Todo(
                            id: $0.id,
                            todo: $0.todo,
                            completed: $0.completed,
                            userID: $0.userID
                        )
                    )}
                    completion(.success(todos))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }

}

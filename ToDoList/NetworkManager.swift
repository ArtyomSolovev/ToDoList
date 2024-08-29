import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()

    private init(){}
    
    let urlString = "https://dummyjson.com/todos"
    
    func fetchData(completion: @escaping (Result<[Todo], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(Welcome.self, from: data)
                var todos = [Todo]()
                data.todos.forEach {
                    let todo = Todo(
                            id: UUID(),
                            header: $0.header,
                            todo: $0.text,
                            completed: $0.isCompleted,
                            date: Date.getCurrectDate()
                        )
                    todos.append(todo)
                }
                completion(.success(todos))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

}

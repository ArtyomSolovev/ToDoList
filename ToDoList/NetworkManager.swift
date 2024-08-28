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
                data.todos.forEach{
                    todos.append(
                    Todo(
                        id: $0.id,
                        todo: $0.todo,
                        completed: $0.completed,
                        date: Date.getCurrectDate()
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

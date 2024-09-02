import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let queue = DispatchQueue(label: "CoreDataQueue")
    private init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    
    func createTodo(todo: Todo) {
        queue.async { [self] in
            guard let taskEntityDescription = NSEntityDescription.entity(forEntityName: Constants.nameOfEntityTask.rawValue, in: context) else { return }
            let task = Task(entity: taskEntityDescription, insertInto: context)
            task.id = todo.id
            task.header = todo.header
            task.text = todo.text
            task.isCompleted = todo.isCompleted
            task.date = todo.date
            
            appDelegate.saveContext()
        }
    }
    
    func fetchTodos() -> [Task] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: Constants.nameOfEntityTask.rawValue)
        do {
            return (try? context.fetch(fetchRequest) as? [Task]) ?? []
        }
    }
    
    func updataTodo(todo: Todo) {
        queue.async { [self] in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.nameOfEntityTask.rawValue)
            do {
                guard let tasks = try? context.fetch(fetchRequest) as? [Task],
                      let task = tasks.first(where: {$0.id == todo.id}) else { return }
                task.id = todo.id
                task.header = todo.header
                task.text = todo.text
                task.isCompleted = todo.isCompleted
                task.date = todo.date
            }
            appDelegate.saveContext()
        }
    }
    
    func deletaTodo(with id: UUID) {
        queue.async { [self] in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.nameOfEntityTask.rawValue)
            do {
                guard let tasks = try? context.fetch(fetchRequest) as? [Task],
                      let task = tasks.first(where: {$0.id == id}) else { return}
                context.delete(task)
            }
            appDelegate.saveContext()
        }
    }
    
}

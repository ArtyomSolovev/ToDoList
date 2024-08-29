import UIKit
import CoreData

public final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func createTask(todo: Todo) {
        guard let taskEntityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let task = Task(entity: taskEntityDescription, insertInto: context)
        task.id = todo.id
        task.header = todo.header
        task.text = todo.text
        task.isCompleted = todo.isCompleted
        task.date = todo.date
        
        appDelegate.saveContext()
    }
    
    public func fetchTasks () -> [Task] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "Task")
        do {
            return (try? context.fetch(fetchRequest) as? [Task]) ?? []
        }
    }
    
//    public func fetchTask(with id: UUID) -> Task? {
//        let fetchRequest = NSFetchRequest <NSFetchRequestResult>(entityName: "Task")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
//        do {
//            let task = try? context.fetch(fetchRequest) as? [Task]
//            return task?.first
//        }
//    }
    
    func updataTask(todo: Todo) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
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
    
    public func deletaTask(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            guard let tasks = try? context.fetch(fetchRequest) as? [Task],
                  let task = tasks.first(where: {$0.id == id}) else { return}
            context.delete(task)
        }
        appDelegate.saveContext()
    }
    
}

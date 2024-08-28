import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {}

extension Task {

//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
//        return NSFetchRequest<Task>(entityName: "Task")
//    }

    @NSManaged public var id: Int16
    @NSManaged public var header: String?
    @NSManaged public var text: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var date: String?

}

extension Task : Identifiable {}

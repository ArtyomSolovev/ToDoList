import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {}

extension Task {

    @NSManaged public var id: UUID
    @NSManaged public var header: String?
    @NSManaged public var text: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var date: String?

}

extension Task : Identifiable {}

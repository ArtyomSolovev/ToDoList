import Foundation

extension Date {
    static func getCurrectDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        let formattedDate = dateFormatter.string(from: today)
        return formattedDate
    }
}

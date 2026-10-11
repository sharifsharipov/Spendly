import Foundation

extension Date {
    var shortDate: String {
        formatted(.dateTime.day().month(.abbreviated))
    }

    var fullDate: String {
        formatted(.dateTime.day().month(.wide).year())
    }

    var timeString: String {
        formatted(.dateTime.hour().minute())
    }
}

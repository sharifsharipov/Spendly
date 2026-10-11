import Foundation

enum Route: Hashable {
    // Home
    case transactionDetail(Transaction)
    case addTransaction

    // Goals
    case goalDetail
    case addGoal

    // Statistics
    case statisticsDetail

    // Profile
    case editProfile
}

enum Sheet: Identifiable {
    case addTransaction
    case addGoal

    var id: String { "\(self)" }
}

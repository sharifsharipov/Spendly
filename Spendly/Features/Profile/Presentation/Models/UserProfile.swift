import Foundation

struct UserProfile: Codable {
    var name: String
    var currency: String
    var monthlyBudget: Double
    var notificationsEnabled: Bool

    static let `default` = UserProfile(
        name: "",
        currency: "USD",
        monthlyBudget: 0,
        notificationsEnabled: false
    )
}

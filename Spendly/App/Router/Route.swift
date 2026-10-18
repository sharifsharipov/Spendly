import Foundation

enum Route: Hashable {
    case transactionDetail(Transaction)
    case goalDetail(Goal)
    case addGoal
    case statisticsDetail
    case editProfile
    case themeView
    case languageView
    case habitsView
}

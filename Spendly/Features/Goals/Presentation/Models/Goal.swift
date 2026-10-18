import Foundation

struct Goal: Identifiable, Codable, Hashable {
    static func == (lhs: Goal, rhs: Goal) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    var id: UUID
    var title: String
    var targetAmount: Double
    var currentAmount: Double
    var deadline: Date?
    var icon: String
    var colorName: String

    var progress: Double { min(currentAmount / targetAmount, 1.0) }
    var isCompleted: Bool { currentAmount >= targetAmount }
    var remaining: Double { max(targetAmount - currentAmount, 0) }

    init(
        id: UUID = UUID(),
        title: String,
        targetAmount: Double,
        currentAmount: Double = 0,
        deadline: Date? = nil,
        icon: String = "star.fill",
        colorName: String = "blue"
    ) {
        self.id = id
        self.title = title
        self.targetAmount = targetAmount
        self.currentAmount = currentAmount
        self.deadline = deadline
        self.icon = icon
        self.colorName = colorName
    }
}

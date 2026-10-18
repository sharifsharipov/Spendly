import Foundation
import Observation

@Observable
final class AddGoalViewModel {
    var title: String = ""
    var targetAmountText: String = ""
    var deadline: Date = Calendar.current.date(byAdding: .month, value: 3, to: .now)!
    var hasDeadline: Bool = false
    var selectedIcon: String = "star.fill"
    var selectedColor: String = "blue"

    let availableIcons = [
        "star.fill", "house.fill", "car.fill", "airplane",
        "graduationcap.fill", "heart.fill", "gift.fill", "briefcase.fill"
    ]

    let availableColors = ["blue", "green", "orange", "purple", "pink", "red"]

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty && parsedAmount > 0
    }

    private var parsedAmount: Double {
        Double(targetAmountText.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    private let addGoal: AddGoalUseCase

    init(repository: GoalRepository = GoalRepositoryImpl()) {
        addGoal = AddGoalUseCase(repository: repository)
    }

    func save() {
        addGoal.execute(buildGoal())
    }

    private func buildGoal() -> Goal {
        Goal(
            title: title.trimmingCharacters(in: .whitespaces),
            targetAmount: parsedAmount,
            deadline: hasDeadline ? deadline : nil,
            icon: selectedIcon,
            colorName: selectedColor
        )
    }
}

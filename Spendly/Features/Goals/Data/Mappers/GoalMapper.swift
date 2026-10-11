import Foundation

struct GoalMapper {
    static func toEntity(_ g: Goal) -> GoalEntity {
        GoalEntity(
            id: g.id.uuidString,
            title: g.title,
            targetAmount: g.targetAmount,
            currentAmount: g.currentAmount,
            deadline: g.deadline?.timeIntervalSince1970,
            icon: g.icon,
            colorName: g.colorName
        )
    }

    static func toModel(_ e: GoalEntity) -> Goal {
        Goal(
            id: UUID(uuidString: e.id) ?? UUID(),
            title: e.title,
            targetAmount: e.targetAmount,
            currentAmount: e.currentAmount,
            deadline: e.deadline.map { Date(timeIntervalSince1970: $0) },
            icon: e.icon,
            colorName: e.colorName
        )
    }
}

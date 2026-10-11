import Foundation

final class AddGoalUseCase {
    private let repository: GoalRepository
    init(repository: GoalRepository) { self.repository = repository }
    func execute(_ goal: Goal) { repository.insert(goal) }
}

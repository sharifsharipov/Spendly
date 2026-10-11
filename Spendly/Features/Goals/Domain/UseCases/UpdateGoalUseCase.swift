import Foundation

final class UpdateGoalUseCase {
    private let repository: GoalRepository
    init(repository: GoalRepository) { self.repository = repository }
    func execute(_ goal: Goal) { repository.update(goal) }
}

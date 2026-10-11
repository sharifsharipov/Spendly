import Foundation

final class DeleteGoalUseCase {
    private let repository: GoalRepository
    init(repository: GoalRepository) { self.repository = repository }
    func execute(id: UUID) { repository.delete(id: id) }
}

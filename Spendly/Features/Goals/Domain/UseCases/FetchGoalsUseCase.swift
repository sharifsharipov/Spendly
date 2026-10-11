import Foundation

final class FetchGoalsUseCase {
    private let repository: GoalRepository
    init(repository: GoalRepository) { self.repository = repository }
    func execute() -> [Goal] { repository.fetchAll() }
}

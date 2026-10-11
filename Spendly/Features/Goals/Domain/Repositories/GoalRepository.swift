import Foundation

protocol GoalRepository {
    func fetchAll() -> [Goal]
    func insert(_ goal: Goal)
    func delete(id: UUID)
    func update(_ goal: Goal)
}

import Foundation

final class GoalRepositoryImpl: GoalRepository {
    private let dataSource = GoalLocalDataSource()

    func fetchAll() -> [Goal] {
        dataSource.fetchAll().map { GoalMapper.toModel($0) }
    }

    func insert(_ g: Goal) {
        dataSource.insert(GoalMapper.toEntity(g))
    }

    func delete(id: UUID) {
        dataSource.delete(id: id.uuidString)
    }

    func update(_ g: Goal) {
        dataSource.update(GoalMapper.toEntity(g))
    }
}

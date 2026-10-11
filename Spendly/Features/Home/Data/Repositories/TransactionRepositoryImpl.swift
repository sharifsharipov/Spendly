import Foundation

final class TransactionRepositoryImpl: TransactionRepository {
    private let dataSource = TransactionLocalDataSource()

    func fetchAll() -> [Transaction] {
        dataSource.fetchAll().compactMap { TransactionMapper.toModel($0) }
    }

    func insert(_ t: Transaction) {
        dataSource.insert(TransactionMapper.toEntity(t))
    }

    func delete(id: UUID) {
        dataSource.delete(id: id.uuidString)
    }

    func update(_ t: Transaction) {
        dataSource.update(TransactionMapper.toEntity(t))
    }
}

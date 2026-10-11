import Foundation

protocol TransactionRepository {
    func fetchAll() -> [Transaction]
    func insert(_ transaction: Transaction)
    func delete(id: UUID)
    func update(_ transaction: Transaction)
}

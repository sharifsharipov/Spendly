import Foundation

final class UpdateTransactionUseCase {
    private let repository: TransactionRepository

    init(repository: TransactionRepository) {
        self.repository = repository
    }

    func execute(_ transaction: Transaction) {
        repository.update(transaction)
    }
}

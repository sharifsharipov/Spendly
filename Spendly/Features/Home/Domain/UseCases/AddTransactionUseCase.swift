import Foundation

final class AddTransactionUseCase {
    private let repository: TransactionRepository

    init(repository: TransactionRepository) {
        self.repository = repository
    }

    func execute(_ transaction: Transaction) {
        repository.insert(transaction)
    }
}

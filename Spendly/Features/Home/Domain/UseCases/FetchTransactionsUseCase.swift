import Foundation

final class FetchTransactionsUseCase {
    private let repository: TransactionRepository

    init(repository: TransactionRepository) {
        self.repository = repository
    }

    func execute() -> [Transaction] {
        repository.fetchAll()
    }
}

import Foundation

final class DeleteTransactionUseCase {
    private let repository: TransactionRepository

    init(repository: TransactionRepository) {
        self.repository = repository
    }

    func execute(id: UUID) {
        repository.delete(id: id)
    }
}

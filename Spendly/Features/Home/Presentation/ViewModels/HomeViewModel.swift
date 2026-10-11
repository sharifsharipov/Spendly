import Foundation
import Observation

@Observable
final class HomeViewModel {
    var transactions: [Transaction] = []
    var goals: [Goal] = []

    private let fetchTransactions: FetchTransactionsUseCase
    private let addTransaction: AddTransactionUseCase
    private let deleteTransaction: DeleteTransactionUseCase
    private let updateTransaction: UpdateTransactionUseCase

    init(repository: TransactionRepository = TransactionRepositoryImpl()) {
        fetchTransactions  = FetchTransactionsUseCase(repository: repository)
        addTransaction     = AddTransactionUseCase(repository: repository)
        deleteTransaction  = DeleteTransactionUseCase(repository: repository)
        updateTransaction  = UpdateTransactionUseCase(repository: repository)
    }

    var totalBalance: Double {
        transactions.reduce(0) { $1.type == .income ? $0 + $1.amount : $0 - $1.amount }
    }

    var totalIncome: Double {
        transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }

    var totalExpenses: Double {
        transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }

    var recentTransactions: [Transaction] {
        Array(transactions.sorted { $0.date > $1.date }.prefix(5))
    }

    var activeGoals: [Goal] {
        goals.filter { !$0.isCompleted }.prefix(3).map { $0 }
    }

    func load() {
        transactions = fetchTransactions.execute()
    }

    func add(_ transaction: Transaction) {
        addTransaction.execute(transaction)
        transactions.append(transaction)
    }

    func delete(_ transaction: Transaction) {
        deleteTransaction.execute(id: transaction.id)
        transactions.removeAll { $0.id == transaction.id }
    }

    func update(_ transaction: Transaction) {
        updateTransaction.execute(transaction)
        if let i = transactions.firstIndex(where: { $0.id == transaction.id }) {
            transactions[i] = transaction
        }
    }
}

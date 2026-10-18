import Foundation
import Observation

@Observable
final class StatisticsViewModel {
    var transactions: [Transaction] = []
    var selectedPeriod: StatsPeriod = .month

    private let fetchTransactions: FetchTransactionsUseCase

    init(repository: TransactionRepository = TransactionRepositoryImpl()) {
        fetchTransactions = FetchTransactionsUseCase(repository: repository)
    }

    var filteredTransactions: [Transaction] {
        let now = Date.now
        let from: Date
        switch selectedPeriod {
        case .week:  from = Calendar.current.date(byAdding: .day,   value: -7,  to: now)!
        case .month: from = Calendar.current.date(byAdding: .month, value: -1,  to: now)!
        case .year:  from = Calendar.current.date(byAdding: .year,  value: -1,  to: now)!
        }
        return transactions.filter { $0.date >= from }
    }

    var totalIncome: Double {
        filteredTransactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }

    var totalExpenses: Double {
        filteredTransactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }

    var categoryStats: [CategoryStat] {
        let expenses = filteredTransactions.filter { $0.type == .expense }
        return Category.allCases.compactMap { category in
            let amount = expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
            guard amount > 0 else { return nil }
            let percentage = totalExpenses > 0 ? amount / totalExpenses : 0
            return CategoryStat(category: category, amount: amount, percentage: percentage)
        }.sorted { $0.amount > $1.amount }
    }

    func load() {
        transactions = fetchTransactions.execute()
    }
}

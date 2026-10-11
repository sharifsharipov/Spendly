import Foundation
import Observation

@Observable
final class StatisticsViewModel {

    var transactions: [Transaction] = []
    var selectedPeriod: StatsPeriod = .month

    var filteredTransactions: [Transaction] {
        let now = Date.now
        let from: Date
        switch selectedPeriod {
        case .week:  from = Calendar.current.date(byAdding: .day, value: -7, to: now)!
        case .month: from = Calendar.current.date(byAdding: .month, value: -1, to: now)!
        case .year:  from = Calendar.current.date(byAdding: .year, value: -1, to: now)!
        }
        return transactions.filter { $0.date >= from }
    }

    var totalIncome: Double {
        filteredTransactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }

    var totalExpenses: Double {
        filteredTransactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }

    var expensesByCategory: [(category: Category, amount: Double)] {
        let expenses = filteredTransactions.filter { $0.type == .expense }
        return Category.allCases.compactMap { category in
            let total = expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
            return total > 0 ? (category, total) : nil
        }.sorted { $0.amount > $1.amount }
    }

    func load() {
        // TODO: Load from persistence
    }
}

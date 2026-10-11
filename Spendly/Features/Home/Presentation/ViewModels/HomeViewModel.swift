import Foundation
import Observation

@Observable
final class HomeViewModel {

    var transactions: [Transaction] = []
    var goals: [Goal] = []

    var totalBalance: Double {
        transactions.reduce(0) {
            $1.type == .income ? $0 + $1.amount : $0 - $1.amount
        }
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
        // TODO: Load from persistence
    }
}

import Foundation

// Shared model — used across Home and Statistics features

enum TransactionType: String, Codable, CaseIterable {
    case income  = "Income"
    case expense = "Expense"
}

enum Category: String, Codable, CaseIterable, Identifiable {
    case food          = "Food"
    case transport     = "Transport"
    case shopping      = "Shopping"
    case entertainment = "Entertainment"
    case health        = "Health"
    case housing       = "Housing"
    case salary        = "Salary"
    case savings       = "Savings"
    case other         = "Other"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .food:          return "fork.knife"
        case .transport:     return "car.fill"
        case .shopping:      return "bag.fill"
        case .entertainment: return "tv.fill"
        case .health:        return "heart.fill"
        case .housing:       return "house.fill"
        case .salary:        return "dollarsign.circle.fill"
        case .savings:       return "banknote.fill"
        case .other:         return "ellipsis.circle.fill"
        }
    }
}

struct Transaction: Identifiable, Codable {
    var id: UUID
    var title: String
    var amount: Double
    var type: TransactionType
    var category: Category
    var date: Date
    var note: String?

    init(
        id: UUID = UUID(),
        title: String,
        amount: Double,
        type: TransactionType,
        category: Category,
        date: Date = .now,
        note: String? = nil
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.type = type
        self.category = category
        self.date = date
        self.note = note
    }
}

import Foundation
import SwiftUI

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

    var color: Color {
        switch self {
        case .food:          return Color(hex: "FF6B35")
        case .transport:     return Color(hex: "1B93FE")
        case .shopping:      return Color(hex: "7E5FA6")
        case .entertainment: return Color(hex: "DD1470")
        case .health:        return Color(hex: "0CB867")
        case .housing:       return Color(hex: "00B4D8")
        case .salary:        return Color(hex: "0CB867")
        case .savings:       return Color(hex: "3A86FF")
        case .other:         return Color(hex: "909090")
        }
    }
}

struct Transaction: Identifiable, Codable, Hashable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
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

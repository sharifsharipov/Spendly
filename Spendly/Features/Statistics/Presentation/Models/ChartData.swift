import Foundation

enum StatsPeriod: String, CaseIterable, Identifiable {
    case week  = "Week"
    case month = "Month"
    case year  = "Year"

    var id: String { rawValue }
}

struct CategoryStat: Identifiable {
    var id: String { category.rawValue }
    let category: Category
    let amount: Double
    let percentage: Double
}

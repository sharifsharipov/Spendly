import Foundation
import Observation

@Observable
final class AddTransactionViewModel {
    var title: String = ""
    var amount: String = ""
    var type: TransactionType = .expense
    var category: Category = .food
    var date: Date = .now
    var note: String = ""

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        (Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0) > 0
    }

    func buildTransaction() -> Transaction? {
        guard let value = Double(amount.replacingOccurrences(of: ",", with: ".")) else { return nil }
        return Transaction(
            title: title.trimmingCharacters(in: .whitespaces),
            amount: value,
            type: type,
            category: category,
            date: date,
            note: note.isEmpty ? nil : note
        )
    }

    func reset() {
        title = ""; amount = ""; type = .expense
        category = .food; date = .now; note = ""
    }
}

import Foundation

struct TransactionMapper {
    static func toEntity(_ t: Transaction) -> TransactionEntity {
        TransactionEntity(
            id: t.id.uuidString,
            title: t.title,
            amount: t.amount,
            type: t.type.rawValue,
            category: t.category.rawValue,
            date: t.date.timeIntervalSince1970,
            note: t.note
        )
    }

    static func toModel(_ e: TransactionEntity) -> Transaction? {
        guard
            let id       = UUID(uuidString: e.id),
            let type     = TransactionType(rawValue: e.type),
            let category = Category(rawValue: e.category)
        else { return nil }
        return Transaction(
            id: id,
            title: e.title,
            amount: e.amount,
            type: type,
            category: category,
            date: Date(timeIntervalSince1970: e.date),
            note: e.note
        )
    }
}

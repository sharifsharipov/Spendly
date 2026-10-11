import Foundation

final class TransactionLocalDataSource {
    private let db = SQLiteDatabase.shared

    func fetchAll() -> [TransactionEntity] {
        db.query("SELECT * FROM transactions ORDER BY date DESC").compactMap { row in
            guard
                let id       = row["id"]?.textValue,
                let title    = row["title"]?.textValue,
                let amount   = row["amount"]?.realValue,
                let type     = row["type"]?.textValue,
                let category = row["category"]?.textValue,
                let date     = row["date"]?.realValue
            else { return nil }
            return TransactionEntity(
                id: id,
                title: title,
                amount: amount,
                type: type,
                category: category,
                date: date,
                note: row["note"]?.textValue
            )
        }
    }

    func insert(_ e: TransactionEntity) {
        db.execute(
            "INSERT OR REPLACE INTO transactions (id,title,amount,type,category,date,note) VALUES (?,?,?,?,?,?,?)",
            [
                .text(e.id),
                .text(e.title),
                .real(e.amount),
                .text(e.type),
                .text(e.category),
                .real(e.date),
                e.note != nil ? .text(e.note!) : .null
            ]
        )
    }

    func delete(id: String) {
        db.execute("DELETE FROM transactions WHERE id = ?", [.text(id)])
    }

    func update(_ e: TransactionEntity) {
        insert(e)
    }
}

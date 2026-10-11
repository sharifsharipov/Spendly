import Foundation

final class GoalLocalDataSource {
    private let db = SQLiteDatabase.shared

    func fetchAll() -> [GoalEntity] {
        db.query("SELECT * FROM goals ORDER BY title ASC").compactMap { row in
            guard
                let id            = row["id"]?.textValue,
                let title         = row["title"]?.textValue,
                let targetAmount  = row["target_amount"]?.realValue,
                let currentAmount = row["current_amount"]?.realValue,
                let icon          = row["icon"]?.textValue,
                let colorName     = row["color_name"]?.textValue
            else { return nil }
            return GoalEntity(
                id: id,
                title: title,
                targetAmount: targetAmount,
                currentAmount: currentAmount,
                deadline: row["deadline"]?.realValue,
                icon: icon,
                colorName: colorName
            )
        }
    }

    func insert(_ e: GoalEntity) {
        db.execute(
            "INSERT OR REPLACE INTO goals (id,title,target_amount,current_amount,deadline,icon,color_name) VALUES (?,?,?,?,?,?,?)",
            [
                .text(e.id),
                .text(e.title),
                .real(e.targetAmount),
                .real(e.currentAmount),
                e.deadline != nil ? .real(e.deadline!) : .null,
                .text(e.icon),
                .text(e.colorName)
            ]
        )
    }

    func delete(id: String) {
        db.execute("DELETE FROM goals WHERE id = ?", [.text(id)])
    }

    func update(_ e: GoalEntity) {
        insert(e)
    }
}

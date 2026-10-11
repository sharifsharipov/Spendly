import Foundation
import SQLite3

final class SQLiteDatabase {
    static let shared = SQLiteDatabase()
    private var db: OpaquePointer?
    private let transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    private init() {
        let path = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("spendly.db").path
        guard sqlite3_open(path, &db) == SQLITE_OK else { return }
        createTables()
    }

    private func createTables() {
        sqlite3_exec(db, """
        CREATE TABLE IF NOT EXISTS transactions (
            id       TEXT PRIMARY KEY,
            title    TEXT NOT NULL,
            amount   REAL NOT NULL,
            type     TEXT NOT NULL,
            category TEXT NOT NULL,
            date     REAL NOT NULL,
            note     TEXT
        )
        """, nil, nil, nil)

        sqlite3_exec(db, """
        CREATE TABLE IF NOT EXISTS goals (
            id             TEXT PRIMARY KEY,
            title          TEXT NOT NULL,
            target_amount  REAL NOT NULL,
            current_amount REAL NOT NULL,
            deadline       REAL,
            icon           TEXT NOT NULL,
            color_name     TEXT NOT NULL
        )
        """, nil, nil, nil)
    }

    func execute(_ sql: String, _ args: [DatabaseValue] = []) {
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return }
        bind(stmt, args)
        sqlite3_step(stmt)
        sqlite3_finalize(stmt)
    }

    func query(_ sql: String, _ args: [DatabaseValue] = []) -> [[String: DatabaseValue]] {
        var stmt: OpaquePointer?
        var rows: [[String: DatabaseValue]] = []
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return rows }
        bind(stmt, args)
        while sqlite3_step(stmt) == SQLITE_ROW {
            var row: [String: DatabaseValue] = [:]
            let count = sqlite3_column_count(stmt)
            for i in 0..<count {
                let col = String(cString: sqlite3_column_name(stmt, i))
                switch sqlite3_column_type(stmt, i) {
                case SQLITE_TEXT:
                    row[col] = .text(String(cString: sqlite3_column_text(stmt, i)))
                case SQLITE_FLOAT:
                    row[col] = .real(sqlite3_column_double(stmt, i))
                default:
                    row[col] = .null
                }
            }
            rows.append(row)
        }
        sqlite3_finalize(stmt)
        return rows
    }

    private func bind(_ stmt: OpaquePointer?, _ args: [DatabaseValue]) {
        for (i, arg) in args.enumerated() {
            let idx = Int32(i + 1)
            switch arg {
            case .text(let v):  sqlite3_bind_text(stmt, idx, v, -1, transient)
            case .real(let v):  sqlite3_bind_double(stmt, idx, v)
            case .null:         sqlite3_bind_null(stmt, idx)
            }
        }
    }
}

enum DatabaseValue {
    case text(String)
    case real(Double)
    case null

    var textValue: String? {
        if case .text(let v) = self { return v }
        return nil
    }

    var realValue: Double? {
        if case .real(let v) = self { return v }
        return nil
    }
}

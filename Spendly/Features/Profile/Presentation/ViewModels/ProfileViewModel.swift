import Foundation
import Observation

enum AppTheme: String, CaseIterable {
    case system, light, dark

    var title: String {
        switch self {
        case .system: "System"
        case .light:  "Light"
        case .dark:   "Dark"
        }
    }

    var icon: String {
        switch self {
        case .system: "circle.lefthalf.filled"
        case .light:  "sun.max"
        case .dark:   "moon.stars"
        }
    }
}

enum AppLanguage: String, CaseIterable {
    case english = "en"
    case russian = "ru"
    case uzbek   = "uz"

    var title: String {
        switch self {
        case .english: "English"
        case .russian: "Русский"
        case .uzbek:   "O'zbek"
        }
    }

    var shortTitle: String {
        switch self {
        case .english: "EN"
        case .russian: "RU"
        case .uzbek:   "UZ"
        }
    }

    var flag: String {
        switch self {
        case .english: "🇺🇸"
        case .russian: "🇷🇺"
        case .uzbek:   "🇺🇿"
        }
    }
}

@Observable
final class ProfileViewModel {

    var name: String = UserDefaults.standard.string(forKey: "userName") ?? "" {
        didSet { UserDefaults.standard.set(name, forKey: "userName") }
    }

    var currency: String = UserDefaults.standard.string(forKey: "currency") ?? "USD" {
        didSet { UserDefaults.standard.set(currency, forKey: "currency") }
    }

    var monthlyBudget: Double = UserDefaults.standard.double(forKey: "monthlyBudget") {
        didSet { UserDefaults.standard.set(monthlyBudget, forKey: "monthlyBudget") }
    }

    var appTheme: AppTheme = AppTheme(rawValue: UserDefaults.standard.string(forKey: "appTheme") ?? "") ?? .system {
        didSet { UserDefaults.standard.set(appTheme.rawValue, forKey: "appTheme") }
    }

    var selectedLanguage: AppLanguage = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "appLanguage") ?? "") ?? .english {
        didSet {
            UserDefaults.standard.set(selectedLanguage.rawValue, forKey: "appLanguage")
            AppLocalizer.shared.language = selectedLanguage.rawValue
        }
    }

    var dailyReminderEnabled: Bool = UserDefaults.standard.bool(forKey: "dailyReminderEnabled") {
        didSet { UserDefaults.standard.set(dailyReminderEnabled, forKey: "dailyReminderEnabled") }
    }

    var dailyReminderTime: Date = {
        let t = UserDefaults.standard.double(forKey: "dailyReminderTime")
        return t > 0
            ? Date(timeIntervalSince1970: t)
            : Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date()) ?? Date()
    }() {
        didSet { UserDefaults.standard.set(dailyReminderTime.timeIntervalSince1970, forKey: "dailyReminderTime") }
    }

    var weeklyReportEnabled: Bool = UserDefaults.standard.bool(forKey: "weeklyReportEnabled") {
        didSet { UserDefaults.standard.set(weeklyReportEnabled, forKey: "weeklyReportEnabled") }
    }

    var budgetAlertEnabled: Bool = UserDefaults.standard.bool(forKey: "budgetAlertEnabled") {
        didSet { UserDefaults.standard.set(budgetAlertEnabled, forKey: "budgetAlertEnabled") }
    }

    var savingsReminderEnabled: Bool = UserDefaults.standard.bool(forKey: "savingsReminderEnabled") {
        didSet { UserDefaults.standard.set(savingsReminderEnabled, forKey: "savingsReminderEnabled") }
    }

    let availableCurrencies = ["USD", "EUR", "GBP", "JPY", "UZS", "RUB"]

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var initials: String {
        name.split(separator: " ")
            .prefix(2)
            .compactMap { $0.first.map { String($0) } }
            .joined()
            .uppercased()
    }

    func resetAllData() {
    }
}

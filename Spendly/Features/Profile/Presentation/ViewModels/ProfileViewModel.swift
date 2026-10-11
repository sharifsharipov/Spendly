import Foundation
import Observation

@Observable
final class ProfileViewModel {

    var name: String {
        get { UserDefaults.standard.string(forKey: "userName") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "userName") }
    }

    var currency: String {
        get { UserDefaults.standard.string(forKey: "currency") ?? "USD" }
        set { UserDefaults.standard.set(newValue, forKey: "currency") }
    }

    var notificationsEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "notificationsEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "notificationsEnabled") }
    }

    var monthlyBudget: Double {
        get { UserDefaults.standard.double(forKey: "monthlyBudget") }
        set { UserDefaults.standard.set(newValue, forKey: "monthlyBudget") }
    }

    let availableCurrencies = ["USD", "EUR", "GBP", "JPY", "UZS", "RUB"]

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    func resetAllData() {
        // TODO: Clear all Core Data records
    }
}

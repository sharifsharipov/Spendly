import Foundation
import Observation

@Observable
final class AppLocalizer {
    static let shared = AppLocalizer()

    var language: String = UserDefaults.standard.string(forKey: "appLanguage") ?? "en" {
        didSet { UserDefaults.standard.set(language, forKey: "appLanguage") }
    }

    private let table: [String: [String: String]] = [
        "profile":          ["en": "Profile",          "ru": "Профиль",       "uz": "Profil"],
        "edit_profile":     ["en": "Edit Profile",     "ru": "Редактировать", "uz": "Tahrirlash"],
        "your_name":        ["en": "Your Name",        "ru": "Ваше имя",      "uz": "Ismingiz"],
        "appearance":       ["en": "Appearance",       "ru": "Внешний вид",   "uz": "Ko'rinish"],
        "habits":           ["en": "Habits",           "ru": "Привычки",      "uz": "Odatlar"],
        "general":          ["en": "General",          "ru": "Основное",      "uz": "Umumiy"],
        "about":            ["en": "About",            "ru": "О приложении",  "uz": "Ilova haqida"],
        "theme":            ["en": "Theme",            "ru": "Тема",          "uz": "Mavzu"],
        "theme_system":     ["en": "System",           "ru": "Системная",     "uz": "Tizim"],
        "theme_light":      ["en": "Light",            "ru": "Светлая",       "uz": "Yorug'"],
        "theme_dark":       ["en": "Dark",             "ru": "Тёмная",        "uz": "Qorang'i"],
        "language":         ["en": "Language",         "ru": "Язык",          "uz": "Til"],
        "daily_reminder":       ["en": "Daily Reminder",       "ru": "Ежедневное напоминание",          "uz": "Kundalik eslatma"],
        "log_expenses_daily":   ["en": "Log expenses every day","ru": "Записывайте расходы каждый день","uz": "Har kuni xarajatlarni yozing"],
        "reminder_time":        ["en": "Reminder Time",        "ru": "Время напоминания",               "uz": "Eslatma vaqti"],
        "weekly_report":        ["en": "Weekly Report",        "ru": "Еженедельный отчёт",              "uz": "Haftalik hisobot"],
        "summary_monday":       ["en": "Summary every Monday", "ru": "Сводка каждый понедельник",       "uz": "Har dushanba xulosasi"],
        "budget_alert":         ["en": "Budget Alert",         "ru": "Бюджетное оповещение",            "uz": "Byudjet ogohlantirishí"],
        "alert_monthly_limit":  ["en": "Alert when near monthly limit","ru": "Предупреждение при превышении","uz": "Oylik limitga yaqinlashganda ogohlantirish"],
        "goal_reminder":        ["en": "Goal Reminder",        "ru": "Напоминание о цели",              "uz": "Maqsad eslatmasi"],
        "remind_save_goals":    ["en": "Remind to save towards goals","ru": "Напоминать откладывать на цели","uz": "Maqsad uchun tejashni eslatish"],
        "currency":         ["en": "Currency",         "ru": "Валюта",        "uz": "Valyuta"],
        "monthly_budget":   ["en": "Monthly Budget",   "ru": "Месячный бюджет","uz": "Oylik byudjet"],
        "not_set":          ["en": "Not set",          "ru": "Не задан",      "uz": "Belgilanmagan"],
        "app_version":      ["en": "App Version",      "ru": "Версия",        "uz": "Versiya"],
        "reset_all_data":   ["en": "Reset All Data",   "ru": "Сбросить данные","uz": "Ma'lumotlarni tozalash"],
        "reset_title":      ["en": "Reset All Data?",  "ru": "Сбросить все данные?","uz": "Barcha ma'lumotlarni tozalash?"],
        "reset_message":    ["en": "This will delete all transactions and goals. This cannot be undone.",
                             "ru": "Это удалит все транзакции и цели. Действие нельзя отменить.",
                             "uz": "Bu barcha tranzaksiya va maqsadlarni o'chiradi. Bekor qilib bo'lmaydi."],
        "reset_confirm":    ["en": "Reset",            "ru": "Сбросить",      "uz": "Tozalash"],
        "cancel":           ["en": "Cancel",           "ru": "Отмена",        "uz": "Bekor qilish"],
    ]

    func t(_ key: String) -> String {
        table[key]?[language] ?? table[key]?["en"] ?? key
    }
}

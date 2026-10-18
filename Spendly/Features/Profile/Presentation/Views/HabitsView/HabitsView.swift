import SwiftUI

struct HabitsView: View {
    @Environment(AppLocalizer.self) private var loc

    @AppStorage("dailyReminderEnabled")   private var dailyReminderEnabled: Bool  = false
    @AppStorage("weeklyReportEnabled")    private var weeklyReportEnabled: Bool   = false
    @AppStorage("budgetAlertEnabled")     private var budgetAlertEnabled: Bool    = false
    @AppStorage("savingsReminderEnabled") private var savingsReminderEnabled: Bool = false

    @State private var dailyReminderTime: Date = {
        let t = UserDefaults.standard.double(forKey: "dailyReminderTime")
        return t > 0
            ? Date(timeIntervalSince1970: t)
            : Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date()) ?? Date()
    }()

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HabitToggleRow(
                    icon: "bell.fill", color: AppColors.warning,
                    title: loc.t("daily_reminder"),
                    subtitle: loc.t("log_expenses_daily"),
                    isOn: $dailyReminderEnabled
                )

                if dailyReminderEnabled {
                    ReminderTimePicker(time: $dailyReminderTime)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }

                HabitToggleRow(
                    icon: "chart.bar.fill", color: AppColors.secondary,
                    title: loc.t("weekly_report"),
                    subtitle: loc.t("summary_monday"),
                    isOn: $weeklyReportEnabled
                )

                HabitToggleRow(
                    icon: "exclamationmark.triangle.fill", color: AppColors.error,
                    title: loc.t("budget_alert"),
                    subtitle: loc.t("alert_monthly_limit"),
                    isOn: $budgetAlertEnabled
                )

                HabitToggleRow(
                    icon: "target", color: AppColors.success,
                    title: loc.t("goal_reminder"),
                    subtitle: loc.t("remind_save_goals"),
                    isOn: $savingsReminderEnabled
                )
            }
            .padding()
            .animation(.easeInOut(duration: 0.2), value: dailyReminderEnabled)
        }
        .background(AppColors.background)
        .navigationTitle(loc.t("habits"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ContentView()
}

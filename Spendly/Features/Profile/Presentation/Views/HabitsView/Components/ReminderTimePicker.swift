import SwiftUI

struct ReminderTimePicker: View {
    @Environment(\.textStyles) var ts
    @Environment(AppLocalizer.self) private var loc

    let time: Binding<Date>

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppColors.grey73.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: "clock")
                    .font(.system(size: 18))
                    .foregroundStyle(AppColors.grey73)
            }
            Text(loc.t("reminder_time"))
                .textStyle(ts.manrope16w500)
            Spacer()
            DatePicker("", selection: time, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .tint(AppColors.success)
                .onChange(of: time.wrappedValue) { _, new in
                    UserDefaults.standard.set(new.timeIntervalSince1970, forKey: "dailyReminderTime")
                }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 14))
    }
}

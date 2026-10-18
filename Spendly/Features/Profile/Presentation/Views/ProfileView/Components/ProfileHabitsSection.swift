import SwiftUI

struct ProfileHabitsSection: View {
    @Environment(AppLocalizer.self) private var loc
    @Environment(AppRouter.self) private var router

    var body: some View {
        SectionCard(label: loc.t("habits")) {
            Button { router.push(.habitsView) } label: {
                SettingRow(icon: "repeat", iconColor: AppColors.success, title: loc.t("habits")) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(AppColors.grey73)
                }
            }
            .buttonStyle(.plain)
        }
    }
}

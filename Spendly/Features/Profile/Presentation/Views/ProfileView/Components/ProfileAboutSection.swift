import SwiftUI

struct ProfileAboutSection: View {
    @Environment(\.textStyles) var ts
    @Environment(AppLocalizer.self) private var loc
    let appVersion: String
    let onResetTap: () -> Void

    var body: some View {
        SectionCard(label: loc.t("about")) {
            SettingRow(icon: "info.circle.fill", iconColor: AppColors.info, title: loc.t("app_version")) {
                Text(appVersion)
                    .textStyle(ts.manrope14w400)
                    .foregroundStyle(AppColors.grey73)
            }

            Divider().padding(.leading, 52)

            Button(action: onResetTap) {
                SettingRow(icon: "trash.fill", iconColor: AppColors.error, title: loc.t("reset_all_data")) {
                    EmptyView()
                }
                .foregroundStyle(AppColors.error)
            }
            .buttonStyle(.plain)
        }
    }
}

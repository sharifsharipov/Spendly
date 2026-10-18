import SwiftUI

struct ProfileAppearanceSection: View {
    @Environment(AppLocalizer.self) private var loc
    @Environment(AppRouter.self) private var router
    @Environment(\.textStyles) var ts
    @Bindable var vm: ProfileViewModel

    @AppStorage("appTheme") private var appThemeRaw: String = "system"
    private var currentTheme: AppTheme {
        AppTheme(rawValue: appThemeRaw) ?? .system
    }

    var body: some View {
        SectionCard(label: loc.t("appearance")) {
            Button { router.push(.themeView) } label: {
                SettingRow(icon: "paintbrush.fill", iconColor: AppColors.tertiary, title: loc.t("theme")) {
                    HStack(spacing: 6) {
                        Image(systemName: currentTheme.icon)
                            .font(.system(size: 13))
                            .foregroundStyle(AppColors.grey73)
                        Text(loc.t("theme_\(appThemeRaw)"))
                            .font(.custom("Manrope-Medium", size: 13))
                            .foregroundStyle(AppColors.grey73)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(AppColors.grey73)
                    }
                }
            }
            .buttonStyle(.plain)

            Divider().padding(.leading, 52)

            Button { router.push(.languageView) } label: {
                SettingRow(icon: "globe", iconColor: AppColors.secondary, title: loc.t("language")) {
                    HStack(spacing: 6) {
                        Text("\(vm.selectedLanguage.flag) \(vm.selectedLanguage.shortTitle)")
                            .font(.custom("Manrope-Medium", size: 13))
                            .foregroundStyle(AppColors.grey73)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(AppColors.grey73)
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }
}

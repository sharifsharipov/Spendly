import SwiftUI

struct ProfileGeneralSection: View {
    @Environment(\.textStyles) var ts
    @Environment(AppLocalizer.self) private var loc
    @Bindable var vm: ProfileViewModel
    let onBudgetTap: () -> Void

    var body: some View {
        SectionCard(label: loc.t("general")) {
            SettingRow(icon: "dollarsign.circle.fill", iconColor: AppColors.success, title: loc.t("currency")) {
                Picker("", selection: $vm.currency) {
                    ForEach(vm.availableCurrencies, id: \.self) { c in
                        Text(c).tag(c)
                    }
                }
                .pickerStyle(.menu)
                .tint(AppColors.primary)
            }

            Divider().padding(.leading, 52)

            Button(action: onBudgetTap) {
                SettingRow(icon: "calendar.badge.clock", iconColor: AppColors.primary, title: loc.t("monthly_budget")) {
                    HStack(spacing: 6) {
                        Text(vm.monthlyBudget > 0 ? vm.monthlyBudget.toCurrency() : loc.t("not_set"))
                            .textStyle(ts.manrope14w400)
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

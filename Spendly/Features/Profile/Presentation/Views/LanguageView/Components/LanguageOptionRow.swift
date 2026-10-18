import SwiftUI

struct LanguageOptionRow: View {
    @Environment(\.textStyles) var ts

    let lang: AppLanguage
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppColors.secondary.opacity(isSelected ? 0.15 : 0.07))
                        .frame(width: 40, height: 40)
                    Text(lang.flag)
                        .font(.system(size: 20))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(lang.title)
                        .textStyle(ts.manrope16w500)
                        .foregroundStyle(isSelected ? AppColors.secondary : AppColors.onSurface)
                    Text(lang.shortTitle)
                        .textStyle(ts.manrope12w400grey)
                }
                Spacer()
                Toggle("", isOn: .constant(isSelected))
                    .labelsHidden()
                    .tint(AppColors.success)
                    .allowsHitTesting(false)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

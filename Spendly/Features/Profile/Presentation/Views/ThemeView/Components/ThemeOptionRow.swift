import SwiftUI

struct ThemeOptionRow: View {
    @Environment(\.textStyles) var ts

    let theme: AppTheme
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppColors.primary.opacity(isSelected ? 0.15 : 0.07))
                        .frame(width: 40, height: 40)
                    Image(systemName: theme.icon)
                        .font(.system(size: 18))
                        .foregroundStyle(isSelected ? AppColors.primary : AppColors.grey73)
                }
                Text(theme.title)
                    .textStyle(ts.manrope16w500)
                    .foregroundStyle(isSelected ? AppColors.primary : AppColors.onSurface)
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

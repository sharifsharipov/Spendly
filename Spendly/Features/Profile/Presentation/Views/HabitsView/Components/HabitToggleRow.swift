import SwiftUI

struct HabitToggleRow: View {
    @Environment(\.textStyles) var ts

    let icon: String
    let color: Color
    let title: String
    let subtitle: String
    let isOn: Binding<Bool>

    var body: some View {
        Button { isOn.wrappedValue.toggle() } label: {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(isOn.wrappedValue ? 0.15 : 0.07))
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundStyle(isOn.wrappedValue ? color : AppColors.grey73)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .textStyle(ts.manrope16w500)
                        .foregroundStyle(isOn.wrappedValue ? color : AppColors.onSurface)
                    Text(subtitle)
                        .textStyle(ts.manrope12w400grey)
                }
                Spacer()
                Toggle("", isOn: isOn)
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

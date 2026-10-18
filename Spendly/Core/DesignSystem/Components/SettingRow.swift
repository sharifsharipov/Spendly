import SwiftUI

struct SettingRow<Trailing: View>: View {
    @Environment(\.textStyles) var ts

    let icon: String
    let iconColor: Color
    let title: String
    var subtitle: String? = nil
    var onTap: (() -> Void)? = nil
    @ViewBuilder let trailing: () -> Trailing

    var body: some View {
        let content = HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(iconColor)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .textStyle(ts.manrope14w400)
                if let subtitle {
                    Text(subtitle)
                        .textStyle(ts.manrope12w400grey)
                }
            }
            Spacer()
            trailing()
        }
        .padding(16)
        .contentShape(Rectangle())

        if let onTap {
            Button(action: onTap) { content }
                .buttonStyle(.plain)
        } else {
            content
        }
    }
}

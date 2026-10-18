import SwiftUI

struct AppTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.custom("Manrope", size: 14))
                .foregroundStyle(AppColors.onSurface)

            TextField(placeholder, text: $text)
                .font(.custom("Manrope", size: 16))
                .foregroundStyle(AppColors.onSurface)
                .keyboardType(keyboardType)
                .padding(14)
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(
                            isFocused ? AppColors.primary : Color.clear,
                            lineWidth: 1.5
                        )
                )
                .focused($isFocused)
        }
    }
}

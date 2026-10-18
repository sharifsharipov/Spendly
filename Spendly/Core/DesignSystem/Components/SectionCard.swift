import SwiftUI

struct SectionCard<Content: View>: View {
    @Environment(\.textStyles) var ts

    let label: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .textStyle(ts.manrope12w400grey)
                .padding(.leading, 4)

            VStack(spacing: 0) {
                content()
            }
            .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))
        }
    }
}

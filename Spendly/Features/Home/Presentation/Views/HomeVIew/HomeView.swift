import SwiftUI

struct HomeView: View {

    @Environment(\.textStyles) var ts
    @Environment(\.colorScheme) var colorScheme
    @State private var toast: ToastMessage?

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // MARK: - 1. Text styles
                VStack(alignment: .leading, spacing: 8) {
                    Text("Poppins 24 Bold")
                        .textStyle(ts.poppins24w700)

                    Text("Manrope 18 SemiBold")
                        .textStyle(ts.manrope18w600)

                    Text("Manrope 16 Medium")
                        .textStyle(ts.manrope16w500)

                    Text("Manrope 14 Regular")
                        .textStyle(ts.manrope14w400)

                    Text("Manrope 12 Grey")
                        .textStyle(ts.manrope12w400grey)

                    Text("Primary color text")
                        .textStyle(ts.manrope14w500primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 12))

                // MARK: - 2. Colors
                VStack(spacing: 8) {
                    colorRow("primary",    AppColors.primary)
                    colorRow("secondary",  AppColors.secondary)
                    colorRow("success",    AppColors.success)
                    colorRow("error",      AppColors.error)
                    colorRow("warning",    AppColors.warning)
                    colorRow("surface",    AppColors.surface)
                    colorRow("outline",    AppColors.outline)
                }
                .padding()
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 12))

                // MARK: - 3. Toast
                VStack(spacing: 12) {
                    Button("Show Success") {
                        toast = ToastMessage(message: "Muvaffaqiyatli saqlandi!", type: .success)
                    }
                    .foregroundStyle(AppColors.success)

                    Button("Show Error") {
                        toast = ToastMessage(message: "Xatolik yuz berdi!", type: .failure)
                    }
                    .foregroundStyle(AppColors.error)

                    Button("Show Info") {
                        toast = ToastMessage(message: "Ma'lumot yangilandi", type: .info)
                    }
                    .foregroundStyle(AppColors.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 12))

                // MARK: - 4. isDarkMode
                HStack {
                    Text(colorScheme == .dark ? "Dark mode" : "Light mode")
                        .textStyle(ts.manrope14w400)
                    Spacer()
                    Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                        .foregroundStyle(AppColors.primary)
                }
                .padding()
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle("Examples")
        .toast($toast)
    }

    private func colorRow(_ name: String, _ color: Color) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 32, height: 32)
            Text(name)
                .textStyle(ts.manrope14w400)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .injectTextStyles()
}

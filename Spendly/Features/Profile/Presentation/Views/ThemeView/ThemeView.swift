import SwiftUI

struct ThemeView: View {
    @AppStorage("appTheme") private var appThemeRaw: String = "system"

    private var selectedTheme: AppTheme {
        AppTheme(rawValue: appThemeRaw) ?? .system
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    ThemeOptionRow(
                        theme: theme,
                        isSelected: selectedTheme == theme,
                        onTap: { appThemeRaw = theme.rawValue }
                    )
                }
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle("Theme")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ContentView()
}

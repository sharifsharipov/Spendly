import SwiftUI

struct LanguageView: View {
    @Environment(AppLocalizer.self) private var loc

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(AppLanguage.allCases, id: \.self) { lang in
                    LanguageOptionRow(
                        lang: lang,
                        isSelected: loc.language == lang.rawValue,
                        onTap: {
                            AppLocalizer.shared.language = lang.rawValue
                            UserDefaults.standard.set(lang.rawValue, forKey: "appLanguage")
                        }
                    )
                }
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle(loc.t("language"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ContentView()
}

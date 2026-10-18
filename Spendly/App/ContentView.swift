import SwiftUI

struct ContentView: View {
    @State private var homeRouter       = AppRouter()
    @State private var statsRouter      = AppRouter()
    @State private var goalsRouter      = AppRouter()
    @State private var profileRouter    = AppRouter()
    @AppStorage("appTheme") private var appThemeRaw: String = "system"

    private var preferredScheme: ColorScheme? {
        switch appThemeRaw {
        case "light": return .light
        case "dark":  return .dark
        default:      return nil
        }
    }

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        let inactiveColor = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor.white
                : UIColor(red: 0.337, green: 0.365, blue: 0.427, alpha: 1)
        }
        let activeColor = UIColor(red: 0.867, green: 0.082, blue: 0.439, alpha: 1)
        appearance.stackedLayoutAppearance.normal.iconColor = inactiveColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: inactiveColor,
            .font: UIFont(name: "Manrope-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        ]
        appearance.stackedLayoutAppearance.selected.iconColor = activeColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: activeColor,
            .font: UIFont(name: "Manrope-SemiBold", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .semibold)
        ]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            NavigationStack(path: $homeRouter.path) {
                HomeView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .transactionDetail(let tx): TransactionDetailView(transaction: tx)
                        default: EmptyView()
                        }
                    }
            }
            .environment(homeRouter)
            .tabItem {
                Image(AppIcons.home.rawValue)
                Text("Home")
            }

            NavigationStack(path: $statsRouter.path) {
                StatisticsView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .statisticsDetail: StatisticsDetailView()
                        default: EmptyView()
                        }
                    }
            }
            .environment(statsRouter)
            .tabItem {
                Image(AppIcons.statistics.rawValue)
                Text("Statistics")
            }

            NavigationStack(path: $goalsRouter.path) {
                GoalsView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .addGoal:              AddGoalView()
                        case .goalDetail(let goal): GoalDetailView(goal: goal)
                        default: EmptyView()
                        }
                    }
            }
            .environment(goalsRouter)
            .tabItem {
                Image(AppIcons.idea.rawValue)
                Text("Goals")
            }

            NavigationStack(path: $profileRouter.path) {
                ProfileView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .editProfile:    EditProfileView()
                        case .themeView:      ThemeView()
                        case .languageView:   LanguageView()
                        case .habitsView:     HabitsView()
                        default: EmptyView()
                        }
                    }
            }
            .environment(profileRouter)
            .tabItem {
                Image(AppIcons.profile.rawValue)
                Text("Profile")
            }
        }
        .preferredColorScheme(preferredScheme)
        .environment(AppLocalizer.shared)
        .injectTextStyles()
    }
}

#Preview {
    ContentView()
}

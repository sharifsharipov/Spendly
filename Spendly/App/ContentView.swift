import SwiftUI

struct ContentView: View {

    @State private var router = AppRouter()

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        let inactiveColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.white : UIColor(red: 0.337, green: 0.365, blue: 0.427, alpha: 1)
        }
        let activeColor = UIColor(red: 0.867, green: 0.082, blue: 0.439, alpha: 1) // #DD1470

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
            NavigationStack(path: $router.path) {
                HomeView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .transactionDetail: TransactionDetailView()
                        case .addTransaction:    AddTransactionView()
                        case .goalDetail:        GoalDetailView()
                        case .addGoal:           AddGoalView()
                        case .statisticsDetail:  StatisticsDetailView()
                        case .editProfile:       EditProfileView()
                        }
                    }
            }
            .tabItem {
                Image(AppIcons.home.rawValue)
                Text("Home")
            }

            NavigationStack {
                StatisticsView()
            }
            .tabItem {
                Image(AppIcons.statistics.rawValue)
                Text("Statistics")
            }

            NavigationStack {
                GoalsView()
            }
            .tabItem {
                Image(AppIcons.idea.rawValue)
                Text("Goals")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(AppIcons.profile.rawValue)
                Text("Profile")
            }
        }
        .environment(router)
        .injectTextStyles()
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct ContentView: View {

    @State private var router = AppRouter()

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? .white : .black
        }
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor { trait in
                trait.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }
        ]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemYellow
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.systemYellow
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
                Image(AppIcons.goals.rawValue)
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
    }
}

#Preview {
    ContentView()
}

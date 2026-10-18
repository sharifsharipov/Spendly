import SwiftUI

struct GoalsView: View {
    @Environment(\.textStyles) var ts
    @Environment(AppRouter.self) private var router
    @State private var vm = GoalsViewModel()

    var body: some View {
        Group {
            if vm.goals.isEmpty {
                VStack {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "target")
                            .font(.system(size: 40))
                            .foregroundStyle(AppColors.grey73)
                        Text("No goals yet")
                            .textStyle(ts.manrope14w400)
                            .foregroundStyle(AppColors.grey73)
                        Text("Tap + to create your first goal")
                            .textStyle(ts.manrope12w400grey)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 16) {

                        GoalsSummaryCard(totalSaved: vm.totalSaved, totalTarget: vm.totalTarget)

                        if !vm.activeGoals.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Active Goals")
                                    .textStyle(ts.manrope18w600)

                                ForEach(vm.activeGoals) { goal in
                                    Button { router.push(.goalDetail(goal)) } label: {
                                        GoalRowView(goal: goal)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }

                        if !vm.completedGoals.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Completed")
                                    .textStyle(ts.manrope18w600)

                                ForEach(vm.completedGoals) { goal in
                                    CompletedGoalRowView(goal: goal)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .background(AppColors.background)
        .navigationTitle("Goals")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { router.push(.addGoal) } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(AppColors.onSurface)
                }
            }
        }
        .onAppear { vm.load() }
    }
}

#Preview {
    ContentView()
}

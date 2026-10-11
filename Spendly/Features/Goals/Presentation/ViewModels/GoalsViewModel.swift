import Foundation
import Observation

@Observable
final class GoalsViewModel {
    var goals: [Goal] = []

    private let fetchGoals:  FetchGoalsUseCase
    private let addGoal:     AddGoalUseCase
    private let deleteGoal:  DeleteGoalUseCase
    private let updateGoal:  UpdateGoalUseCase

    init(repository: GoalRepository = GoalRepositoryImpl()) {
        fetchGoals  = FetchGoalsUseCase(repository: repository)
        addGoal     = AddGoalUseCase(repository: repository)
        deleteGoal  = DeleteGoalUseCase(repository: repository)
        updateGoal  = UpdateGoalUseCase(repository: repository)
    }

    var activeGoals: [Goal]    { goals.filter { !$0.isCompleted } }
    var completedGoals: [Goal] { goals.filter { $0.isCompleted } }
    var totalSaved: Double     { goals.reduce(0) { $0 + $1.currentAmount } }
    var totalTarget: Double    { goals.reduce(0) { $0 + $1.targetAmount } }

    func load() {
        goals = fetchGoals.execute()
    }

    func add(_ goal: Goal) {
        addGoal.execute(goal)
        goals.append(goal)
    }

    func delete(_ goal: Goal) {
        deleteGoal.execute(id: goal.id)
        goals.removeAll { $0.id == goal.id }
    }

    func addAmount(_ amount: Double, to goal: Goal) {
        var updated = goal
        updated.currentAmount = min(goal.currentAmount + amount, goal.targetAmount)
        updateGoal.execute(updated)
        if let i = goals.firstIndex(where: { $0.id == goal.id }) {
            goals[i] = updated
        }
    }
}

import Foundation
import Observation

@Observable
final class GoalsViewModel {

    var goals: [Goal] = []

    var activeGoals: [Goal] {
        goals.filter { !$0.isCompleted }
    }

    var completedGoals: [Goal] {
        goals.filter { $0.isCompleted }
    }

    var totalSaved: Double {
        goals.reduce(0) { $0 + $1.currentAmount }
    }

    var totalTarget: Double {
        goals.reduce(0) { $0 + $1.targetAmount }
    }

    func delete(_ goal: Goal) {
        goals.removeAll { $0.id == goal.id }
        // TODO: Persist deletion
    }

    func addAmount(_ amount: Double, to goal: Goal) {
        guard let index = goals.firstIndex(where: { $0.id == goal.id }) else { return }
        goals[index].currentAmount = min(goals[index].currentAmount + amount, goals[index].targetAmount)
        // TODO: Persist update
    }

    func load() {
        // TODO: Load from persistence
    }
}

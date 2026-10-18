import SwiftUI

struct GoalDetailView: View {
    @Environment(\.textStyles) var ts
    @Environment(AppRouter.self) private var router

    @State private var goal: Goal
    @State private var showAddMoney = false
    @State private var showDeleteAlert = false
    @State private var addAmountText = ""

    private let updateGoal = UpdateGoalUseCase(repository: GoalRepositoryImpl())
    private let deleteGoal = DeleteGoalUseCase(repository: GoalRepositoryImpl())

    init(goal: Goal) {
        _goal = State(initialValue: goal)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(Color(goal.colorName).opacity(0.15))
                            .frame(width: 80, height: 80)
                        Image(systemName: goal.icon)
                            .foregroundStyle(Color(goal.colorName))
                            .font(.system(size: 32))
                    }

                    ZStack {
                        Circle()
                            .stroke(Color(goal.colorName).opacity(0.15), lineWidth: 14)
                        Circle()
                            .trim(from: 0, to: goal.progress)
                            .stroke(
                                Color(goal.colorName),
                                style: StrokeStyle(lineWidth: 14, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut(duration: 0.5), value: goal.progress)

                        VStack(spacing: 4) {
                            Text(String(format: "%.0f%%", goal.progress * 100))
                                .textStyle(ts.poppins24w700)
                            Text(goal.isCompleted ? "Completed!" : "completed")
                                .textStyle(ts.manrope12w400grey)
                        }
                    }
                    .frame(width: 160, height: 160)
                }
                .frame(maxWidth: .infinity)
                .padding(24)
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 20))

                HStack(spacing: 0) {
                    VStack(spacing: 4) {
                        Text("Saved")
                            .textStyle(ts.manrope12w400grey)
                        Text(goal.currentAmount.toCurrency())
                            .textStyle(ts.poppins18w600)
                    }
                    .frame(maxWidth: .infinity)

                    Divider().frame(height: 40)

                    VStack(spacing: 4) {
                        Text("Remaining")
                            .textStyle(ts.manrope12w400grey)
                        Text(goal.remaining.toCurrency())
                            .textStyle(ts.poppins18w600)
                    }
                    .frame(maxWidth: .infinity)

                    Divider().frame(height: 40)

                    VStack(spacing: 4) {
                        Text("Target")
                            .textStyle(ts.manrope12w400grey)
                        Text(goal.targetAmount.toCurrency())
                            .textStyle(ts.poppins18w600)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 16)
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))

                if let deadline = goal.deadline {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(AppColors.primary)
                            .font(.system(size: 18))
                        Text("Deadline")
                            .textStyle(ts.manrope14w400)
                        Spacer()
                        Text(deadline.formatted(date: .abbreviated, time: .omitted))
                            .textStyle(ts.manrope14w500primary)
                    }
                    .padding(16)
                    .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))
                }

                if !goal.isCompleted {
                    Button {
                        addAmountText = ""
                        showAddMoney = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Money")
                        }
                        .textStyle(ts.manrope16w500)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(AppColors.primary, in: RoundedRectangle(cornerRadius: 14))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle(goal.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showDeleteAlert = true } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(AppColors.error)
                }
            }
        }
        .alert("Delete Goal?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                deleteGoal.execute(id: goal.id)
                router.pop()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
        .sheet(isPresented: $showAddMoney) {
            addMoneySheet
        }
    }

    private var addMoneySheet: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Cancel") { showAddMoney = false }
                    .foregroundStyle(AppColors.grey73)
                Spacer()
                Text("Add Money")
                    .textStyle(ts.manrope18w600)
                Spacer()
                Button("Save") {
                    let amount = Double(addAmountText.replacingOccurrences(of: ",", with: ".")) ?? 0
                    guard amount > 0 else { return }
                    goal.currentAmount = min(goal.currentAmount + amount, goal.targetAmount)
                    updateGoal.execute(goal)
                    showAddMoney = false
                }
                .textStyle(ts.manrope14w500primary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(AppColors.surface)

            Divider()

            VStack(spacing: 20) {
                AppTextField(
                    label: "Amount",
                    placeholder: "0.00",
                    text: $addAmountText,
                    keyboardType: .decimalPad
                )

                HStack {
                    Text("Remaining:")
                        .textStyle(ts.manrope14w400)
                    Spacer()
                    Text(goal.remaining.toCurrency())
                        .textStyle(ts.manrope14w500primary)
                }
            }
            .padding()

            Spacer()
        }
        .background(AppColors.background)
        .presentationDetents([.height(280)])
    }
}

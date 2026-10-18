import SwiftUI

struct GoalRowView: View {
    @Environment(\.textStyles) var ts
    let goal: Goal

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color(goal.colorName).opacity(0.15))
                        .frame(width: 44, height: 44)
                    Image(systemName: goal.icon)
                        .foregroundStyle(Color(goal.colorName))
                        .font(.system(size: 18))
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(goal.title)
                        .textStyle(ts.manrope16w500)
                    if let deadline = goal.deadline {
                        Text(deadline.formatted(date: .abbreviated, time: .omitted))
                            .textStyle(ts.manrope12w400grey)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(goal.currentAmount.toCurrency())
                        .textStyle(ts.manrope14w400)
                    Text(goal.targetAmount.toCurrency())
                        .textStyle(ts.manrope12w400grey)
                }
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(AppColors.outline)
                        .frame(height: 6)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(goal.colorName))
                        .frame(width: geo.size.width * goal.progress, height: 6)
                }
            }
            .frame(height: 6)

            HStack {
                Spacer()
                Text(String(format: "%.0f%% completed", goal.progress * 100))
                    .textStyle(ts.manrope12w400grey)
            }
        }
        .padding(16)
        .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))
    }
}

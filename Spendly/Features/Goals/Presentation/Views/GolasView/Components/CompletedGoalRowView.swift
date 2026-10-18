import SwiftUI

struct CompletedGoalRowView: View {
    @Environment(\.textStyles) var ts
    let goal: Goal

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(AppColors.success.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: "checkmark")
                    .foregroundStyle(AppColors.success)
                    .font(.system(size: 16, weight: .bold))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(goal.title)
                    .textStyle(ts.manrope16w500)
                Text(goal.targetAmount.toCurrency())
                    .textStyle(ts.manrope12w400grey)
            }

            Spacer()

            Image(systemName: "trophy.fill")
                .foregroundStyle(AppColors.warning)
        }
        .padding(16)
        .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))
    }
}

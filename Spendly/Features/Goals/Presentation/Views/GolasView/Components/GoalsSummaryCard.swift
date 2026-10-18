import SwiftUI

struct GoalsSummaryCard: View {
    @Environment(\.textStyles) var ts
    let totalSaved: Double
    let totalTarget: Double

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Saved")
                        .textStyle(ts.manrope12w400grey)
                    Text(totalSaved.toCurrency())
                        .textStyle(ts.poppins24w700)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Target")
                        .textStyle(ts.manrope12w400grey)
                    Text(totalTarget.toCurrency())
                        .textStyle(ts.manrope16w500)
                }
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(AppColors.outline)
                        .frame(height: 8)
                    RoundedRectangle(cornerRadius: 6)
                        .fill(AppColors.primary)
                        .frame(
                            width: totalTarget > 0
                                ? geo.size.width * min(totalSaved / totalTarget, 1)
                                : 0,
                            height: 8
                        )
                }
            }
            .frame(height: 8)
        }
        .padding(16)
        .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))
    }
}

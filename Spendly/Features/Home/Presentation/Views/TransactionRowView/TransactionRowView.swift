import SwiftUI

struct TransactionRowView: View {
    @Environment(\.textStyles) var ts
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(transaction.category.color.opacity(0.15))
                    .frame(width: 46, height: 46)
                Image(systemName: transaction.category.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(transaction.category.color)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(transaction.title)
                    .textStyle(ts.manrope14w400)
                    .foregroundStyle(AppColors.onSurface)
                    .lineLimit(1)
                Text(transaction.category.rawValue)
                    .textStyle(ts.manrope12w400grey)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 3) {
                Text((transaction.type == .income ? "+" : "-") + transaction.amount.toCurrency())
                    .font(ts.manrope14w400.font).fontWeight(.bold)
                    .foregroundStyle(transaction.type == .income ? AppColors.success : AppColors.error)
                Text(transaction.date.shortDate)
                    .textStyle(ts.manrope12w400grey)
            }
        }
        .padding(14)
        .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    VStack(spacing: 12) {
        TransactionRowView(transaction: Transaction(title: "Lunch", amount: 25, type: .expense, category: .food))
        TransactionRowView(transaction: Transaction(title: "Salary", amount: 3500, type: .income, category: .salary))
        TransactionRowView(transaction: Transaction(title: "Cinema", amount: 12, type: .expense, category: .entertainment))
    }
    .padding()
    .background(AppColors.background)
    .injectTextStyles()
}

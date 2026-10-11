import SwiftUI

struct TransactionDetailView: View {
    @Environment(\.textStyles) var ts
    let transaction: Transaction

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(transaction.category.color.opacity(0.15))
                            .frame(width: 72, height: 72)
                        Image(systemName: transaction.category.icon)
                            .font(.system(size: 28, weight: .medium))
                            .foregroundStyle(transaction.category.color)
                    }

                    Text((transaction.type == .income ? "+" : "-") + transaction.amount.toCurrency())
                        .font(.custom("Poppins-Bold", size: 34))
                        .foregroundStyle(transaction.type == .income ? AppColors.success : AppColors.error)

                    Text(transaction.title)
                        .textStyle(ts.manrope16w500)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 28)
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))

                VStack(spacing: 0) {
                    detailRow("Category", transaction.category.rawValue)
                    divider
                    detailRow("Type", transaction.type == .income ? "Income" : "Expense")
                    divider
                    detailRow("Date", transaction.date.fullDate)
                    divider
                    detailRow("Time", transaction.date.timeString)
                    if let note = transaction.note, !note.isEmpty {
                        divider
                        detailRow("Note", note)
                    }
                }
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    private var divider: some View {
        Rectangle()
            .fill(AppColors.outline)
            .frame(height: 1)
            .padding(.horizontal, 16)
    }

    private func detailRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .textStyle(ts.manrope14w400)
                .foregroundStyle(AppColors.grey73)
            Spacer()
            Text(value)
                .textStyle(ts.manrope14w400)
                .foregroundStyle(AppColors.onSurface)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    NavigationStack {
        TransactionDetailView(transaction: Transaction(
            title: "Lunch", amount: 25.00, type: .expense, category: .food,
            note: "Lunch with friends"
        ))
    }
    .injectTextStyles()
}

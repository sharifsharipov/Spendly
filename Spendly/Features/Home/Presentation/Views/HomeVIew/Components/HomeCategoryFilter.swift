import SwiftUI

enum TransactionCategory: String, CaseIterable {
    case all       = "All"
    case income    = "Income"
    case expense   = "Expense"
    case food      = "Food"
    case transport = "Transport"
    case shopping  = "Shopping"
    case health    = "Health"
}

struct HomeCategoryFilter: View {
    @Binding var selected: TransactionCategory
    @Environment(\.colorScheme) var colorScheme

    private var inactiveBg: Color {
        colorScheme == .dark ? AppColors.surfaceContainerHighest : .white
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(TransactionCategory.allCases, id: \.self) { category in
                    Button {
                        selected = category
                    } label: {
                        Text(category.rawValue)
                            .font(.custom("Manrope-Medium", size: 13))
                            .foregroundStyle(selected == category ? Color(hex: "1A1A1A") : AppColors.onSurface)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                selected == category ? AppColors.warning : inactiveBg,
                                in: Capsule()
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(AppColors.surface)
    }
}

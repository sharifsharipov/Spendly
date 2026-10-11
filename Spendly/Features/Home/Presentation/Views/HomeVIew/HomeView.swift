import SwiftUI

struct HomeView: View {
    @Environment(\.textStyles) var ts
    @Environment(AppRouter.self) private var router
    @State private var selectedCategory: TransactionCategory = .all
    @State private var showAddTransaction = false
    @State private var vm = HomeViewModel()

    private var filteredTransactions: [Transaction] {
        let sorted = vm.transactions.sorted { $0.date > $1.date }
        switch selectedCategory {
        case .all:       return Array(sorted.prefix(5))
        case .income:    return sorted.filter { $0.type == .income }
        case .expense:   return sorted.filter { $0.type == .expense }
        case .food:      return sorted.filter { $0.category == .food }
        case .transport: return sorted.filter { $0.category == .transport }
        case .shopping:  return sorted.filter { $0.category == .shopping }
        case .health:    return sorted.filter { $0.category == .health }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HomeCategoryFilter(selected: $selectedCategory)

            if filteredTransactions.isEmpty {
                Spacer()
                emptyState
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        HStack {
                            Text(selectedCategory == .all ? "Recent Transactions" : selectedCategory.rawValue)
                                .textStyle(ts.manrope18w600)
                            Spacer()
                            if selectedCategory == .all && vm.transactions.count > 5 {
                                Button("See all") {}
                                    .textStyle(ts.manrope14w500primary)
                            }
                        }

                        ForEach(filteredTransactions) { tx in
                            Button {
                                router.push(.transactionDetail(tx))
                            } label: {
                                TransactionRowView(transaction: tx)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .background(AppColors.background)
        .navigationTitle("Spendly")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { HomeToolbar(onAdd: { showAddTransaction = true }) }
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $showAddTransaction) {
            AddTransactionView { tx in
                vm.add(tx)
            }
        }
        .onAppear { vm.load() }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.system(size: 40))
                .foregroundStyle(AppColors.grey73)
            Text("No transactions yet")
                .textStyle(ts.manrope14w400)
                .foregroundStyle(AppColors.grey73)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView()
}

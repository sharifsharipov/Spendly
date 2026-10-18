import SwiftUI

struct HomeView: View {
    @Environment(\.textStyles) var ts
    @Environment(AppRouter.self) private var router
    @State private var vm = HomeViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HomeCategoryFilter(selected: $vm.selectedCategory)

            if vm.filteredTransactions.isEmpty {
                Spacer()
                emptyState
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        HStack {
                            Text(vm.selectedCategory == .all ? "Recent Transactions" : vm.selectedCategory.rawValue)
                                .textStyle(ts.manrope18w600)
                            Spacer()
                            if vm.selectedCategory == .all && vm.transactions.count > 5 {
                                Button("See all") {}
                                    .textStyle(ts.manrope14w500primary)
                            }
                        }

                        ForEach(vm.filteredTransactions) { tx in
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
        .toolbar { HomeToolbar(onAdd: { vm.showAddTransaction = true }) }
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $vm.showAddTransaction) {
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

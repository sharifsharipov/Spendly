import SwiftUI

struct StatisticsView: View {
    @Environment(\.textStyles) var ts
    @State private var vm = StatisticsViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                Picker("Period", selection: $vm.selectedPeriod) {
                    ForEach(StatsPeriod.allCases) { period in
                        Text(period.rawValue).tag(period)
                    }
                }
                .pickerStyle(.segmented)

                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundStyle(AppColors.success)
                                .font(.system(size: 14))
                            Text("Income")
                                .textStyle(ts.manrope12w400grey)
                        }
                        Text(vm.totalIncome.toCurrency())
                            .textStyle(ts.poppins18w600)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(
                        AppColors.surfaceContainerHighest,
                        in: RoundedRectangle(cornerRadius: 16)
                    )

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundStyle(AppColors.error)
                                .font(.system(size: 14))
                            Text("Expenses")
                                .textStyle(ts.manrope12w400grey)
                        }
                        Text(vm.totalExpenses.toCurrency())
                            .textStyle(ts.poppins18w600)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(
                        AppColors.surfaceContainerHighest,
                        in: RoundedRectangle(cornerRadius: 16)
                    )
                }

                if vm.categoryStats.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "chart.bar")
                            .font(.system(size: 40))
                            .foregroundStyle(AppColors.grey73)
                        Text("No data for this period")
                            .textStyle(ts.manrope14w400)
                            .foregroundStyle(AppColors.grey73)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 60)
                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Expenses by Category")
                            .textStyle(ts.manrope18w600)

                        ForEach(vm.categoryStats) { stat in
                            VStack(spacing: 8) {
                                HStack {
                                    Image(systemName: stat.category.icon)
                                        .foregroundStyle(stat.category.color)
                                        .frame(width: 20)
                                    Text(stat.category.rawValue)
                                        .textStyle(ts.manrope14w400)
                                    Spacer()
                                    Text(stat.amount.toCurrency())
                                        .textStyle(ts.manrope14w400)
                                    Text(
                                        String(
                                            format: "%.0f%%",
                                            stat.percentage * 100
                                        )
                                    )
                                    .textStyle(ts.manrope12w400grey)
                                    .frame(width: 36, alignment: .trailing)
                                }

                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(AppColors.outline)
                                            .frame(height: 6)
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(stat.category.color)
                                            .frame(
                                                width: geo.size.width
                                                    * stat.percentage,
                                                height: 6
                                            )
                                    }
                                }
                                .frame(height: 6)
                            }
                            .padding(12)
                            .background(
                                AppColors.surfaceContainerHighest,
                                in: RoundedRectangle(cornerRadius: 12)
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle("Statistics")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { vm.load() }
    }
}

#Preview {
    ContentView()
}

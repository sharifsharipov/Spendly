import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.textStyles) var ts
    @State private var vm = AddTransactionViewModel()
    @State private var showDatePicker = false
    var onSave: ((Transaction) -> Void)?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 16) {
                        Picker("", selection: $vm.type) {
                            Text("Expense").tag(TransactionType.expense)
                            Text("Income").tag(TransactionType.income)
                        }
                        .pickerStyle(.segmented)

                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("$")
                                .font(ts.poppins18w600.font)
                                .foregroundStyle(AppColors.grey73)
                            TextField("0.00", text: $vm.amount)
                                .font(.custom("Poppins-Bold", size: 40))
                                .foregroundStyle(vm.type == .income ? AppColors.success : AppColors.error)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(20)
                    .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Category")
                            .textStyle(ts.manrope16w500)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                            ForEach(Category.allCases) { cat in
                                Button {
                                    vm.category = cat
                                } label: {
                                    VStack(spacing: 6) {
                                        ZStack {
                                            Circle()
                                                .fill(vm.category == cat ? cat.color : cat.color.opacity(0.12))
                                                .frame(width: 48, height: 48)
                                            Image(systemName: cat.icon)
                                                .font(.system(size: 18, weight: .medium))
                                                .foregroundStyle(vm.category == cat ? .white : cat.color)
                                        }
                                        Text(cat.rawValue)
                                            .textStyle(ts.manrope12w400grey)
                                            .lineLimit(1)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(16)
                    .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))

                    VStack(spacing: 0) {
                        fieldRow(icon: "tag.fill") {
                            TextField("Title (e.g. Lunch)", text: $vm.title)
                                .textStyle(ts.manrope14w400)
                        }
                        divider
                        Button { showDatePicker = true } label: {
                            fieldRow(icon: "calendar") {
                                Text(vm.date.shortDate)
                                    .textStyle(ts.manrope14w400)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundStyle(AppColors.grey73)
                            }
                        }
                        .buttonStyle(.plain)
                        divider
                        fieldRow(icon: "note.text") {
                            TextField("Note (optional)", text: $vm.note)
                                .textStyle(ts.manrope14w400)
                        }
                    }
                    .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
            .background(AppColors.background)
            .sheet(isPresented: $showDatePicker) {
                VStack(spacing: 20) {
                    Text("Select Date")
                        .textStyle(ts.manrope18w600)
                        .padding(.top, 24)
                    DatePicker("", selection: $vm.date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .tint(AppColors.primary)
                        .padding(.horizontal)
                    Button("Done") { showDatePicker = false }
                        .font(ts.manrope16w500.font)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(AppColors.primary, in: RoundedRectangle(cornerRadius: 14))
                        .padding(.horizontal)
                    Spacer()
                }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .background(AppColors.background)
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(AppColors.surface, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .font(ts.manrope14w400.font)
                        .foregroundStyle(AppColors.grey73)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let tx = vm.buildTransaction() {
                            onSave?(tx)
                            dismiss()
                        }
                    }
                    .font(ts.manrope14w400.font)
                    .foregroundStyle(vm.isValid ? AppColors.primary : AppColors.grey73)
                    .disabled(!vm.isValid)
                }
            }
        }
    }

    private var divider: some View {
        Rectangle()
            .fill(AppColors.outline)
            .frame(height: 1)
            .padding(.horizontal, 16)
    }

    private func fieldRow<Content: View>(icon: String, @ViewBuilder content: () -> Content) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundStyle(AppColors.grey73)
                .frame(width: 20)
            content()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    AddTransactionView()
        .injectTextStyles()
}

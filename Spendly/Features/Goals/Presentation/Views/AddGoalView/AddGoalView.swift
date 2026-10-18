import SwiftUI

struct AddGoalView: View {
    @Environment(\.textStyles) var ts
    @Environment(AppRouter.self) private var router
    @State private var vm = AddGoalViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                AppTextField(
                    label: "Goal Name",
                    placeholder: "e.g. Buy a car",
                    text: $vm.title
                )

                AppTextField(
                    label: "Target Amount",
                    placeholder: "0.00",
                    text: $vm.targetAmountText,
                    keyboardType: .decimalPad
                )

                VStack(alignment: .leading, spacing: 12) {
                    Text("Icon")
                        .textStyle(ts.manrope14w400)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                        ForEach(vm.availableIcons, id: \.self) { icon in
                            Button {
                                vm.selectedIcon = icon
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(vm.selectedIcon == icon ? AppColors.primary.opacity(0.15) : AppColors.surfaceContainerHighest)
                                        .frame(height: 56)
                                    Image(systemName: icon)
                                        .foregroundStyle(vm.selectedIcon == icon ? AppColors.primary : AppColors.grey73)
                                        .font(.system(size: 22))
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(vm.selectedIcon == icon ? AppColors.primary : Color.clear, lineWidth: 1.5)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Color")
                        .textStyle(ts.manrope14w400)
                    HStack(spacing: 12) {
                        ForEach(vm.availableColors, id: \.self) { colorName in
                            Button {
                                vm.selectedColor = colorName
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color(colorName))
                                        .frame(width: 36, height: 36)
                                    if vm.selectedColor == colorName {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 14, weight: .bold))
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        Spacer()
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Toggle(isOn: $vm.hasDeadline) {
                        Text("Set Deadline")
                            .textStyle(ts.manrope14w400)
                    }
                    .tint(AppColors.primary)

                    if vm.hasDeadline {
                        DatePicker("", selection: $vm.deadline, in: Date.now..., displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .tint(AppColors.primary)
                    }
                }
                .padding(14)
                .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 12))

                Button {
                    vm.save()
                    router.pop()
                } label: {
                    Text("Save Goal")
                        .textStyle(ts.manrope16w500)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(vm.isValid ? AppColors.primary : AppColors.grey73, in: RoundedRectangle(cornerRadius: 14))
                }
                .disabled(!vm.isValid)
                .buttonStyle(.plain)
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle("Add Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

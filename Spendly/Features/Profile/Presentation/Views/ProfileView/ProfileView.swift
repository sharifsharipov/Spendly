import SwiftUI

struct ProfileView: View {
    @Environment(AppRouter.self) private var router
    @Environment(AppLocalizer.self) private var loc
    @State private var vm = ProfileViewModel()
    @State private var showResetAlert = false

    var body: some View {
        @Bindable var vm = vm
        ScrollView {
            VStack(spacing: 24) {
                ProfileHeaderCard(
                    initials: vm.initials,
                    name: vm.name,
                    currency: vm.currency,
                    editLabel: loc.t("edit_profile"),
                    namePlaceholder: loc.t("your_name"),
                    onEdit: { router.push(.editProfile) }
                )

                ProfileAppearanceSection(vm: vm)

                ProfileHabitsSection()

                ProfileGeneralSection(vm: vm, onBudgetTap: { router.push(.editProfile) })

                ProfileAboutSection(appVersion: vm.appVersion, onResetTap: { showResetAlert = true })

                Spacer(minLength: 20)
            }
            .padding()
        }
        .background(AppColors.background)
        .navigationTitle(loc.t("profile"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { router.push(.editProfile) } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(AppColors.onSurface)
                }
            }
        }
        .alert(loc.t("reset_title"), isPresented: $showResetAlert) {
            Button(loc.t("reset_confirm"), role: .destructive) { vm.resetAllData() }
            Button(loc.t("cancel"), role: .cancel) {}
        } message: {
            Text(loc.t("reset_message"))
        }
    }
}

#Preview {
    ContentView()
}

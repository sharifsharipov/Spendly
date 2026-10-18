import SwiftUI

struct ProfileHeaderCard: View {
    @Environment(\.textStyles) var ts

    let initials: String
    let name: String
    let currency: String
    let editLabel: String
    let namePlaceholder: String
    let onEdit: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(AppColors.primary.opacity(0.15))
                    .frame(width: 88, height: 88)
                if initials.isEmpty {
                    Image(systemName: "person.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(AppColors.primary)
                } else {
                    Text(initials)
                        .font(.custom("Poppins-Bold", size: 32))
                        .foregroundStyle(AppColors.primary)
                }
            }
            VStack(spacing: 4) {
                Text(name.isEmpty ? namePlaceholder : name)
                    .textStyle(ts.poppins18w600)
                    .foregroundStyle(name.isEmpty ? AppColors.grey73 : AppColors.onSurface)
                Text(currency)
                    .textStyle(ts.manrope12w400grey)
            }
            Button(action: onEdit) {
                Text(editLabel)
                    .textStyle(ts.manrope12w400)
                    .foregroundStyle(AppColors.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(AppColors.primary.opacity(0.1), in: Capsule())
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(AppColors.surfaceContainerHighest, in: RoundedRectangle(cornerRadius: 20))
    }
}

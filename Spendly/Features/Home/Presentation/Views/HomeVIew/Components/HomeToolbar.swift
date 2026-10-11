import SwiftUI

struct HomeToolbar: ToolbarContent {
    var onAdd: () -> Void = {}

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
     
            Button(action: onAdd) {
                Image(systemName: "plus")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(AppColors.onSurface)
            }
        }
    }
}

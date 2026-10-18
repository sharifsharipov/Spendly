/*import SwiftUI
 
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
*/
import SwiftUI
struct StatisticsToolbar : ToolbarContent {
    var onAdd: () -> Void = {}
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading ){
            Image(systemName: "arrow.left")
                
        }
    }
}

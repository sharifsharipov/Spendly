import SwiftUI
import Observation

@Observable
final class AppRouter {

    var path = NavigationPath()
    var sheet: Sheet?
    var isFullScreenPresented = false

    // MARK: - Push / Pop

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        guard !path.isEmpty else { return }
        path.removeLast(path.count)
    }

    // MARK: - Sheet

    func present(_ sheet: Sheet) {
        self.sheet = sheet
    }

    func dismiss() {
        sheet = nil
    }
}

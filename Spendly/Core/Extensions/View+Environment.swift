//
//  View+Environment.swift
//  Spendly
//

import SwiftUI

// MARK: - EnvironmentValues: textStyles
private struct TextStylesKey: EnvironmentKey {
    static let defaultValue = AppTextStyles.light
}

extension EnvironmentValues {
    var textStyles: AppTextStyles {
        get { self[TextStylesKey.self] }
        set { self[TextStylesKey.self] = newValue }
    }
}

// MARK: - Inject textStyles automatically based on colorScheme
struct TextStylesModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .environment(\.textStyles, colorScheme == .dark ? .dark : .light)
    }
}

extension View {
    func injectTextStyles() -> some View {
        modifier(TextStylesModifier())
    }
}

// MARK: - Toast
struct ToastMessage: Equatable {
    enum ToastType { case success, failure, info }
    let message: String
    let type: ToastType
}

struct ToastModifier: ViewModifier {
    @Binding var toast: ToastMessage?
    @State private var isShowing = false

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if let toast {
                    HStack(spacing: 8) {
                        Image(systemName: icon(for: toast.type))
                            .foregroundStyle(.white)
                        Text(toast.message)
                            .font(.custom("Manrope", size: 14))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(background(for: toast.type), in: RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(duration: 0.3), value: toast)
            .onChange(of: toast) { _, newValue in
                if newValue != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        toast = nil
                    }
                }
            }
    }

    private func icon(for type: ToastMessage.ToastType) -> String {
        switch type {
        case .success: return "checkmark.circle.fill"
        case .failure: return "xmark.circle.fill"
        case .info:    return "info.circle.fill"
        }
    }

    private func background(for type: ToastMessage.ToastType) -> Color {
        switch type {
        case .success: return AppColors.success
        case .failure: return AppColors.error
        case .info:    return AppColors.secondary
        }
    }
}

extension View {
    func toast(_ toast: Binding<ToastMessage?>) -> some View {
        modifier(ToastModifier(toast: toast))
    }
}

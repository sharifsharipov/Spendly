//
//  AppFonts.swift
//  Spendly
//
//  Created by Sharif on 11/10/26.
//

import SwiftUI

enum AppFontSize {
    static let xs:   CGFloat = 10
    static let sm:   CGFloat = 12
    static let md:   CGFloat = 14
    static let lg:   CGFloat = 16
    static let xl:   CGFloat = 18
    static let xxl:  CGFloat = 20
    static let xxxl: CGFloat = 24
    static let huge: CGFloat = 32
}

struct TextStyle {
    let font: Font
    let color: Color
}

extension View {
    func textStyle(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .foregroundStyle(style.color)
    }
}

struct AppTextStyles {

    private static let manrope = "Manrope"
    private static let poppins = "Poppins"

    let manrope12w400:       TextStyle
    let manrope12w400grey:   TextStyle
    let manrope12w400white:  TextStyle
    let manrope14w400:       TextStyle
    let manrope14w500primary: TextStyle
    let manrope16w500:       TextStyle
    let manrope18w600:       TextStyle
    let manrope24w400:       TextStyle
    let poppins18w500primary: TextStyle
    let poppins18w600:       TextStyle
    let poppins24w700:       TextStyle

    static let dark = AppTextStyles(
        manrope12w400:        TextStyle(font: .custom(manrope, size: AppFontSize.sm).weight(.regular),   color: .white),
        manrope12w400grey:    TextStyle(font: .custom(manrope, size: AppFontSize.sm).weight(.regular),   color: Color(hex: "94A3B8")),
        manrope12w400white:   TextStyle(font: .custom(manrope, size: AppFontSize.sm).weight(.regular),   color: .white),
        manrope14w400:        TextStyle(font: .custom(manrope, size: AppFontSize.md).weight(.regular),   color: .white),
        manrope14w500primary: TextStyle(font: .custom(manrope, size: AppFontSize.md).weight(.medium),    color: AppColors.primary),
        manrope16w500:        TextStyle(font: .custom(manrope, size: AppFontSize.lg).weight(.medium),    color: .white),
        manrope18w600:        TextStyle(font: .custom(manrope, size: AppFontSize.xl).weight(.semibold),  color: .white),
        manrope24w400:        TextStyle(font: .custom(manrope, size: AppFontSize.xxxl).weight(.regular), color: .white),
        poppins18w500primary: TextStyle(font: .custom(poppins, size: AppFontSize.xl).weight(.medium),    color: AppColors.primary),
        poppins18w600:        TextStyle(font: .custom(poppins, size: AppFontSize.xl).weight(.semibold),  color: .white),
        poppins24w700:        TextStyle(font: .custom(poppins, size: AppFontSize.xxxl).weight(.bold),    color: .white)
    )

    static let light = AppTextStyles(
        manrope12w400:        TextStyle(font: .custom(manrope, size: AppFontSize.sm).weight(.regular),   color: Color(hex: "212121")),
        manrope12w400grey:    TextStyle(font: .custom(manrope, size: AppFontSize.sm).weight(.regular),   color: Color(hex: "9AA4B2")),
        manrope12w400white:   TextStyle(font: .custom(manrope, size: AppFontSize.sm).weight(.regular),   color: .white),
        manrope14w400:        TextStyle(font: .custom(manrope, size: AppFontSize.md).weight(.regular),   color: Color(hex: "212121")),
        manrope14w500primary: TextStyle(font: .custom(manrope, size: AppFontSize.md).weight(.medium),    color: AppColors.primary),
        manrope16w500:        TextStyle(font: .custom(manrope, size: AppFontSize.lg).weight(.medium),    color: Color(hex: "212121")),
        manrope18w600:        TextStyle(font: .custom(manrope, size: AppFontSize.xl).weight(.semibold),  color: Color(hex: "212121")),
        manrope24w400:        TextStyle(font: .custom(manrope, size: AppFontSize.xxxl).weight(.regular), color: Color(hex: "212121")),
        poppins18w500primary: TextStyle(font: .custom(poppins, size: AppFontSize.xl).weight(.medium),    color: AppColors.primary),
        poppins18w600:        TextStyle(font: .custom(poppins, size: AppFontSize.xl).weight(.semibold),  color: Color(hex: "212121")),
        poppins24w700:        TextStyle(font: .custom(poppins, size: AppFontSize.xxxl).weight(.bold),    color: Color(hex: "212121"))
    )
}

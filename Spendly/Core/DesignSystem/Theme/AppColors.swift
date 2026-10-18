//
//  AppColors.swift
//  Spendly
//
//  Created by Sharif on 11/10/26.
//

import SwiftUI

private extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        self.init(
            red:   CGFloat((int >> 16) & 0xFF) / 255,
            green: CGFloat((int >>  8) & 0xFF) / 255,
            blue:  CGFloat( int        & 0xFF) / 255,
            alpha: 1
        )
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        self.init(
            .sRGB,
            red:     Double((int >> 16) & 0xFF) / 255,
            green:   Double((int >>  8) & 0xFF) / 255,
            blue:    Double( int        & 0xFF) / 255,
            opacity: 1
        )
    }
}

enum AppColors {

    static let primary     = Color(hex: "DD1470")
    static let onPrimary   = Color.white
    static let secondary   = Color(hex: "1B93FE")
    static let onSecondary = Color.white
    static let tertiary    = Color(hex: "7E5FA6")
    static let error       = Color(hex: "f75555")
    static let success     = Color(hex: "0CB867")
    static let warning     = Color(hex: "E6BB3D")
    static let info        = Color(hex: "1B93FE")
    static let grey90      = Color(hex: "909090")
    static let grey73      = Color(hex: "737373")
    static let lightGreyF0 = Color(hex: "F0F0F0")

    static let surface = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(hex: "111111")
            : UIColor(hex: "F8FAFC")
    })

    static let onSurface = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? .white
            : UIColor(hex: "212121")
    })

    static let surfaceContainerHighest = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(hex: "1C1C1E")
            : UIColor(hex: "F6F6F6")
    })

    static let outline = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(hex: "2C2C2E")
            : UIColor(hex: "CCCFD7")
    })

    static let outlineVariant = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(hex: "1C1C1E")
            : UIColor(hex: "e2e3ea")
    })

    static let background = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark ? .black : .white
    })

    static let tabBarActive = primary
    static let tabBarInactive = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? .white
            : UIColor(hex: "565d6d")
    })
}

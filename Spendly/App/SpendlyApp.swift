//
//  SpendlyApp.swift
//  Spendly
//
//  Created by Sharif on 11/10/26.
//

import SwiftUI
import CoreText

@main
struct SpendlyApp: App {

    init() {
        registerFonts()
        UISwitch.appearance().onTintColor = UIColor(AppColors.success)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func registerFonts() {
        let fonts = [
            "Manrope-Regular",
            "Manrope-Medium",
            "Manrope-SemiBold",
            "Manrope-Bold",
            "Manrope-Light",
            "Manrope-ExtraLight",
            "Manrope-ExtraBold",
            "Poppins-Thin",
            "Poppins-ExtraLight",
            "Poppins-Light",
            "Poppins-Regular",
            "Poppins-Medium",
            "Poppins-SemiBold",
            "Poppins-Bold",
            "Poppins-ExtraBold",
            "Poppins-Black",
        ]
        fonts.forEach { name in
            guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else { return }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}

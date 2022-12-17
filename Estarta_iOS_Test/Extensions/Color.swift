//
//  UIColor.swift
//  DowidarApp
//
//  Created by Asmaa Ahmed on 07/07/2022.
//

import SwiftUI

extension Color {
    static let redColor = "#E3402D"
    static let princetonOrange = "#F57E25"
    static let extraLightGray = "#F6F6FA"
    static let lightGray = "#BBBBBF"
    static let appBlack = "#0C0C0D"
    
    static let medGrayColor = "#A2A2A2"
    static let grayColor = "#FAFAFA"
    static let darkGrayColor = "#707070"
    
    static let appWhite = "#FFFFFF"
    static let Scorpion = "#606060"
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

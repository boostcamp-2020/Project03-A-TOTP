//
//  Color+.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import SwiftUI

extension Color {
    static let pink1 = Color("pink1")
    static let pink2 = Color("pink2")
    static let mint1 = Color("mint1")
    static let mint2 = Color("mint2")
    static let salmon1 = Color("salmon1")
    static let salmon2 = Color("salmon2")
    static let blue1 = Color("blue1")
    static let blue2 = Color("blue2")
    static let brown1 = Color("brown1")
    static let brown2 = Color("brown2")
    static let navy1 = Color("navy1")
    static let navy2 = Color("navy2")
    static let shadow = Color("shadow")
}

extension LinearGradient {
    static let pink = makeGradient(startColor: Color.pink1, endColor: Color.pink2)
    static let mint = makeGradient(startColor: Color.mint1, endColor: Color.mint2)
    static let salmon = makeGradient(startColor: Color.salmon1, endColor: Color.salmon2)
    static let blue = makeGradient(startColor: Color.blue1, endColor: Color.blue2)
    static let brown = makeGradient(startColor: Color.brown1, endColor: Color.brown2)
    static let navy = makeGradient(startColor: Color.navy1, endColor: Color.navy2)
    
    static func makeGradient(startColor: Color,
                             endColor: Color) -> LinearGradient {
        LinearGradient(gradient: Gradient(colors: [startColor, endColor]),
                       startPoint: .top,
                       endPoint: .bottom)
    }
}

extension String {
    func linearGradientColor() -> LinearGradient {
        switch self {
        case "pink":
            return LinearGradient.pink
        case "mint":
            return LinearGradient.mint
        case "salmon":
            return LinearGradient.salmon
        case "blue":
            return LinearGradient.blue
        case "brown":
            return LinearGradient.brown
        case "navy":
            return LinearGradient.navy
        default:
            return LinearGradient.pink
        }
    }
}

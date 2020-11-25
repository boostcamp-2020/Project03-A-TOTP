//
//  Color+.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import SwiftUI

extension LinearGradient {
    
    func makeGradient(startColor: Color,
                      endColor: Color) -> LinearGradient {
        LinearGradient(gradient: Gradient(colors: [startColor, endColor]),
                       startPoint: .top,
                       endPoint: .bottom)
    }
    
}

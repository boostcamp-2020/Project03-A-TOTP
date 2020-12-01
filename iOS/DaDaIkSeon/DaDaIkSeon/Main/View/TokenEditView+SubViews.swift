//
//  TokenEditView+SubViews.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/01.
//

import SwiftUI

struct IconView: View {
    
    private var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(1...15, id: \.self) { _ in
                Circle()
                    .foregroundColor(.mint1)
                    .frame(width: 35, height: 35, alignment: .center)
                    .padding(4)
            }
        }
    }
    
}

struct PaletteView: View {
    
    var geometry: GeometryProxy
    private var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    private var color: [LinearGradient] = [
        LinearGradient.blue, LinearGradient.brown, LinearGradient.pink,
        LinearGradient.navy, LinearGradient.salmon, LinearGradient.mint
    ]
    
    init(geometry: GeometryProxy) {
        self.geometry = geometry
    }
    
    var body: some View {
    
        LazyVGrid(columns: columns) {
            ForEach(0...5, id: \.self) { index in
                Circle()
                    .fill(color[index])
                    .frame(width: geometry.size.width * 0.15,
                           height: geometry.size.width * 0.15,
                           alignment: .center)
                    .padding(6)
            }
        }
    }
    
}

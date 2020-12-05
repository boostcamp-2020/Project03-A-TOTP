//
//  TokenEditView+SubViews.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/01.
//

import SwiftUI

struct IconView: View {
    
    var action: (String) -> Void
    
    var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var icons: [String] = [
        "search", "message", "game",
        "book", "creditcard", "play",
        "mail", "thumbsup", "calendar",
        "musicNote", "cart", "heart",
        "pin", "bolt", "globe"
    ]
    
    @State var pressedIndex: Int = 0
    
    var body: some View {
        LazyVGrid(columns: columns) {
            
            ForEach(0..<15, id: \.self) { index in
                Button {
                    pressedIndex = index
                    action(icons[index])
                } label: {
                    icons[index].toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 20,
                               maxWidth: 25,
                               minHeight: 20,
                               maxHeight: 25)
                        .padding(5)
                        .foregroundColor(Color.shadow)
                }
                .padding(3)
                .colorMultiply(pressedIndex == index ? Color.black : Color.shadow)
            }

        }
    }
    
}

struct ColorView: View {
    
    var action: (String) -> Void
    var geometryWidth: CGFloat
    
    var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var colors: [String] = [
        "blue", "brown", "pink",
        "navy", "salmon", "mint"
    ]
    
    var body: some View {
    
        LazyVGrid(columns: columns) {
            ForEach(0...5, id: \.self) { index in
                Button {
                    action(colors[index])
                } label: {
                    Circle()
                        .fill(colors[index].linearGradientColor())
                        .frame(width: geometryWidth * 0.15,
                               height: geometryWidth * 0.15,
                               alignment: .center)
                        .padding(6)
                }
            }
        }
    }
    
}

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
    
    private var icons: [String] = [
        "mail", "message", "game",
        "book", "creditcard", "play",
        "search", "thumbsup", "calendar",
        "musicNote", "cart", "heart",
        "pin", "bolt", "globe"
    ]
    
    @State var pressedIndex: Int = 0
    
    var body: some View {
        LazyVGrid(columns: columns) {
            
            ForEach(0..<15, id: \.self) { index in
                Button {
                    pressedIndex = index
                    print("탭탭!", pressedIndex)
                } label: {
                    icons[index].toImage()
                        .padding(12)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(.gray))
                }
                .colorMultiply(pressedIndex == index ? Color.black : Color(.systemGray6))
//              .listRowBackground(pressedIndex == index ?  Color.black : Color(.systemGray6))
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

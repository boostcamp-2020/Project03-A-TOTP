//
//  TokenEditView+SubViews.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/01.
//

import SwiftUI

struct IconView: View {
    
    // 선택한 icon TokenEditView에 넘겨줘야함!
    
    private var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    private var icons: [Image] = [
        Image.mail, Image.message, Image.game,
        Image.book, Image.creditcard, Image.play,
        Image.search, Image.thumbsup, Image.calendar,
        Image.musicNote, Image.cart, Image.heart,
        Image.pin, Image.bolt, Image.globe
    ]
    
    @State var pressedIndex: Int = 0
    
    var body: some View {
        LazyVGrid(columns: columns) {
            
            ForEach(0..<15, id: \.self) { index in
                Button {
                    pressedIndex = index
                    print("탭탭!", pressedIndex)
                } label: {
                    icons[index]
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
    
    // 선택한 색 TokenEditView에 넘겨줘야함!
    
    var geometry: GeometryProxy
    private var columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    private var colors: [LinearGradient] = [
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
                    .fill(colors[index])
                    .frame(width: geometry.size.width * 0.15,
                           height: geometry.size.width * 0.15,
                           alignment: .center)
                    .padding(6)
            }
        }
    }
    
}

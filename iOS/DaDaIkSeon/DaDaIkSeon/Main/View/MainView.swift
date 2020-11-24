//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

struct MainView: View {
    
    @State var tokens = TOTPToken.dummy()
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            MainCellView()
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: 12) {
                    ForEach(tokens.indices) { index in
                        TokenCellView(token: $tokens[index])
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

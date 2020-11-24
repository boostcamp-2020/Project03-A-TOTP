//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

struct MainView: View {
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            MainCellView()
            LazyVGrid(columns: columns,
                      spacing: 12) {
                TokenCellView()
                TokenCellView()
                TokenCellView()
                TokenCellView()
                TokenCellView()
            }
            Spacer()
        }
        .padding(16)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

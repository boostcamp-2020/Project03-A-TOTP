//
//  TokenListView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import SwiftUI

struct TokenListView: View {
    @Binding var tokens: [TokenViewModel]
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns,
                  spacing: 12) {
            ForEach(tokens.indices) { index in
                TokenCellView(token: $tokens[index])
            }
            TokenAddCellView()
        }
    }
}

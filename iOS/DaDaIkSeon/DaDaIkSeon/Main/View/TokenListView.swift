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
                .frame(minHeight: 100)
        }
        .padding([.leading, .trailing, .bottom], 12)
        .padding(.top, 6)
    }
}

struct TokenListView_Previews: PreviewProvider {
    static var previews: some View {
        let tokens = [
            TokenViewModel.init(token: Token(id: UUID(), key: "333 333", tokenName: "token1", color: nil, icon: nil))]
        
        TokenListView(tokens: .constant(tokens))
    }
}

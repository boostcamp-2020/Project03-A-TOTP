//
//  TokenCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI
import CryptoKit

struct TokenCellView: View {
    @Binding var token: TOTPToken
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "circle")
                Spacer()
                Image(systemName: "circle")
            }
            .padding(.horizontal, 12)
            .frame(height: 50, alignment: .center) // 크기를 자동으로 하는 방법 고민
            Spacer()
            HStack {
                Text(token.tokenName ?? "")
                    .font(.system(size: 14))
                    .lineLimit(2)
                Spacer()
            }
            .padding(.horizontal, 12)
            HStack {
                Text(token.key ?? "")
                    .font(.system(size: 18))
                Spacer()                
            }
            .padding(.horizontal, 12)
            Spacer()
        }
        .background(Color.green)
        .cornerRadius(15)
    }
}

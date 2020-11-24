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
                Text("Token Name")
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(.horizontal, 12)
            HStack {
                // makePassword(key: token.key ?? "") ?? ""
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

// struct TokenCellView_Previews: PreviewProvider {
//
//    static var token = TOTPToken(key: "6UAOpz+x3dsNrQ==")
//
//     static var previews: some View {
//        TokenCellView(token: token)
//     }
// }

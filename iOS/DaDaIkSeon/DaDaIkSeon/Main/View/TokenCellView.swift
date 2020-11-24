//
//  TokenCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI

struct TokenCellView: View {
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
                Text("123 456")
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

struct TokenCellView_Previews: PreviewProvider {
    static var previews: some View {
        TokenCellView()
    }
}

//
//  TokenCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI
import CryptoKit

struct TokenCellView: View {
    @Binding var token: TokenViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "heart.circle")
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    // 큰 셀로 Data보내는 Action 추가하는 곳.
                }, label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(.white)
                    
                })
            }
                .padding(.horizontal, 12)
                .frame(height: 50, alignment: .center) // 크기를 자동으로 하는 방법 고민
            
            Spacer()
            
            HStack {
                Text(token.tokenName)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .lineLimit(2)
                Spacer()
            }
                .padding(.horizontal, 12)
            
            HStack {
                Text(token.key)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                Spacer()                
            }
                .padding(.horizontal, 12)
            
            Spacer()
        }
            .background(LinearGradient.salmon)
            .cornerRadius(15)
            .shadow(color: Color.shadow, radius: 6, x: 0, y: 3.0)
    }
}

struct TokenAddCellView: View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "plus.circle")
                    .foregroundColor(Color(.systemGray2))
                Spacer()
            }
            Spacer()
        }
            .padding(.horizontal, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5.0]))
                    .foregroundColor(Color(.systemGray2))
            )
    }
    
}

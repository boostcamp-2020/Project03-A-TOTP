//
//  TokenCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI
import CryptoKit

struct TokenCellView: View {
    
    // MARK: ViewModel
    
    //@Binding var viewModel: TokenViewModel
    @ObservedObject var viewModel: TokenViewModel
    
    // MARK: Body
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "heart.circle")
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20, alignment: .top)
                
                Spacer()
                
                Button(action: {
                    viewModel.showEditView = true
                }, label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .top)
                        .foregroundColor(.white)
                })
                .sheet(isPresented: $viewModel.showEditView) {
                    TokenEditView()
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 50, alignment: .center) // 크기를 자동으로 하는 방법 고민
            
            Spacer()
            
            HStack {
                Text(viewModel.token.tokenName ?? "")
                    .font(.system(size: 11))
                    .foregroundColor(.white)
                    .lineLimit(2)
                Spacer()
            }
            .padding(.horizontal, 12)
            
            HStack {
                (Text(viewModel.password.prefix(3))
                    + Text(" ")
                    + Text(viewModel.password.suffix(3)))
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .kerning(3)
                Spacer()                
            }
            .padding([.horizontal, .bottom], 12)
        }
        .background(viewModel.color.linearGradientColor())
        .cornerRadius(15)
        .shadow(color: Color.shadow, radius: 6, x: 0, y: 3.0)
    }
}

// MARK: TokenAddCellView

struct TokenAddCellView: View {
    
    // MARK: Body
    
    @State var showSheetView = false
    
    var body: some View {
        
        //        NavigationLink(
        //            destination: QRGuideView(),
        //            label: {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
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
        //            })
    }
}

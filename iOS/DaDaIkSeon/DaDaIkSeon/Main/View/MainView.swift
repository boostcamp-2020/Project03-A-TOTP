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

struct MainCellView: View {
    var body: some View {
        ZStack {
            
            // 1
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
                    Spacer()
                    Image(systemName: "circle")
                }
                .padding(.horizontal, 12)
                .frame(height: 50, alignment: .center)
            }
            .background(Color.green)
            .cornerRadius(15)
            
            // 2
            Circle()
                .strokeBorder(Color.white, lineWidth: 15)
                .frame(height: 176)
            
            // 3
            VStack(spacing: 10) {
                Spacer()
                    .frame(height: 30)
                
                Text("Token의 이름\n 2줄까지 가능합니다.")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(
                        width: 150,
                        alignment: .center)
                    
                Text("333 444")
                
                Text("15")
                    .padding(.top)
                
                Spacer()
                    .frame(height: 30)
            }
        }
        .frame(height: 200)
    }
}

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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

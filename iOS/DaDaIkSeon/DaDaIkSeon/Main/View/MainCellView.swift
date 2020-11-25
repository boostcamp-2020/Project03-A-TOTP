//
//  MainCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI

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
                Text("토큰의이름은두줄두줄두줄두줄두줄두줄두줄두줄두줄")
                    .font(.system(size: 14))
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

struct MainCellView_Previews: PreviewProvider {
    static var previews: some View {
        MainCellView()
    }
}

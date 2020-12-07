//
//  ZeroTokenView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/02.
//

import SwiftUI

struct ZeroTokenView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.shadow, radius: 6, x: 0, y: 3.0)
            VStack(alignment: .center) {
                Spacer()
                Image("ddLogo").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55)
                Text("TOTP 토큰이 없으시네요!")
                    .fontWeight(.bold)
                    .foregroundColor(Color.darkNavy)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18))
                    .padding(.bottom)
                Text("아래 ⊕버튼을 누르면\n토큰을 추가하실 수 있어요.")
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        
    }
}

struct ZeroTokenView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZeroTokenView()
                .frame(height: 200)
            Spacer()
        }
    }
}

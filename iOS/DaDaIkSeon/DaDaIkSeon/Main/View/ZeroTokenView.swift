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
            VStack {
                Spacer()
                Text("TOTP 계정을 등록해주세요. 아래 + 버튼을 누르면 추가하실 수 있어욧~!🥰")
                    .padding()
                    
                Spacer()
            }
        }
        .border(Color.black, width: 1)
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

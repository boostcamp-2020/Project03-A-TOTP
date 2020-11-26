//
//  HeaderView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: Body
    
    var body: some View {
        HStack {
            Button(action: {
                // 내 정보 페이지 띄우는 곳
            }, label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.black)
                    .padding(.leading, 4)
            })
            
            Spacer()
            
            Button(action: {
                // Edit Mode로 전환
            }, label: {
                Text("선택")
                    .padding(.trailing, 4)
                    .foregroundColor(.black)
            })
        }.padding([.leading, .trailing], 16)
    }
    
}

struct HeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        HeaderView()
    }
    
}
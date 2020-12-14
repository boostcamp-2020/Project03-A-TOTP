//
//  BackupPasswordView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/15.
//

import SwiftUI

struct BackupPasswordView: View {
    
    @ObservedObject var passwordEntry = Entry(limit: 15)
    @ObservedObject var passwordCheckEntry = Entry(limit: 15)
    
    var body: some View {
        VStack {
            Spacer()
            Image.logo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            Spacer()
            
            Text("토큰을 백업할\n백업 비밀번호를 설정해주세요")
                .multilineTextAlignment(.center)
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("일치하지 않습니다.")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
                
                TextField("15자이내 비밀번호 입력", text: $passwordEntry.text)
                    .padding(8)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .shadow(color: Color.black.opacity(0.1),
                            radius: 5,
                            x: 0.0,
                            y: 0.3)
                    .onChange(of: passwordEntry.text) { _ in
    //                    checkTextChange()
                    }
                
                TextField("비밀번호 확인", text: $passwordCheckEntry.text)
                    .padding(8)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .shadow(color: Color.black.opacity(0.1),
                            radius: 5,
                            x: 0.0,
                            y: 0.3)
                    .onChange(of: passwordCheckEntry.text) { _ in
    //                    checkTextChange()
                    }
            }
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                HStack {
                    Spacer()
                    Text("백업 활성화")
                    Spacer()
                }
            })
            .foregroundColor(.white)
            .frame(width: 110)
            .padding(.vertical, 10)
            .background(LinearGradient.navy)
            .cornerRadius(15)
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}

struct BackupPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        BackupPasswordView()
    }
}

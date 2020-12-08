//
//  LoginView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/06.
//

import SwiftUI

struct LoginView: View {
    
    @State var emailText = ""
    @State var isEmail = false
    @State var checkText = ""
    @State var showingAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            let geometryWidth = geometry.size.width
            let geometryHeight = geometry.size.height
            
            ZStack {
                Image("background")
                    .resizable()
                    .frame(width: geometryWidth)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    Image("ddLogo").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometryWidth * 0.27)
                    Spacer()
                    
                    Text("다다익선 앱을 사용하기 위해\n 이메일 인증이 필요합니다.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.bottom, 16)
                    
                    VStack(alignment: .trailing) {
                        
                        Text(checkText)
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                        
                        HStack {
                            TextField("Email", text: $emailText, onEditingChanged: changeEmailState)
                                .padding(8)
                                .background(Color(.white))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1),
                                        radius: 5,
                                        x: 0.0,
                                        y: 0.3)
                                .onChange(of: emailText) { _ in
                                    checkTextChange()
                                }
                            
                            if isEmail {
                                Button(action: {
                                    print("이메일로 전송한 x자리 코드를 입력하세요. alert")
                                }, label: {
                                    Text("인증")
                                        .font(.system(size: 11))
                                        .foregroundColor(.white)
                                })
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                .background(Color.navy2)
                                .cornerRadius(10)
                                .transition(trailingTransition)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
                .frame(width: geometryWidth * 0.83,
                       height: geometryHeight * 0.855,
                       alignment: .center)
                .background(Color.white)
                .cornerRadius(45)
                .shadow(color: Color.black.opacity(0.1),
                        radius: 10,
                        x: 0.0,
                        y: 0.3)
            }
        }
    }
}

extension LoginView {
    
    var trailingTransition: AnyTransition {
        let movement = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        return .asymmetric(insertion: movement,
                           removal: movement)
    }
    
    func changeEmailState(changed: Bool) {
        withAnimation {
            isEmail = changed
        }
    }
    
    func checkTextChange() {
        // 이메일 체크
        checkText = emailText.count < 3 ? "올바르지 않은 이메일 형식입니다" : ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//
//  LoginView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/06.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: AnyViewModel<LoginState, LoginInput>
    @State private var emailText = ""
    
    init(service: LoginServiceable) {
        viewModel = AnyViewModel(LoginViewModel(service: service))
    }
    
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
                        Text(viewModel.state.checkText)
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
                            
                            if viewModel.state.isEmail {
                                Button(action: {
                                    sendButtonDidTap(emailText)
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
            changed ? viewModel.trigger(.showSendButton) : viewModel.trigger(.hideSendButton)
        }
    }
    
    func checkTextChange() {
        viewModel.trigger(.check(emailText))
    }
    
    func sendButtonDidTap(_ emailText: String) {
        viewModel.trigger(.sendButtonInput(emailText))
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let service = LoginService()
        LoginView(service: service)
    }
}

//
//  LoginEmailView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import SwiftUI

struct LoginEmailView: View {
    
    // MARK: ViewModel
    
    @ObservedObject var viewModel: AnyViewModel<LoginState, LoginInput>
    @State private var emailText = ""
    var geometryWidth: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            Image.logo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geometryWidth * 0.27)
            Spacer()
            
            Text("다다익선 앱을 사용하기 위해\n 이메일 인증이 필요합니다.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.bottom, 16)
            
            VStack(alignment: .trailing) {
                Text(viewModel.state.checkEmailText)
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
                    
                    if viewModel.state.isTyping {
                        Button(action: {
                            sendButtonDidTap(emailText)
                        }, label: {
                            Image.mail
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
    }
    
}

private extension LoginEmailView {
    
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
        viewModel.trigger(.checkEmail(emailText))
    }
    
    func sendButtonDidTap(_ emailText: String) {
        withAnimation {
            viewModel.trigger(.sendButton(emailText))
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let service = LoginService(network: UserNetworkManager())
        LoginView(service: service)
    }
}

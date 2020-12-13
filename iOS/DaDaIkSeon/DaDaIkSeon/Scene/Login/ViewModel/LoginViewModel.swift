//
//  LoginViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/07.
//

import Foundation

final class LoginViewModel: ViewModel {
    
    // MARK: Property
    
    @Published var state: LoginState
    
    init(service: LoginServiceable) {
        let showEmailView = UserDefaults.standard.object(forKey: "isEmailView") as? Bool ?? true
        state = LoginState(service: service,
                           checkEmailText: "",
                           checkCodeText: "",
                           isTyping: false,
                           isEmailView: showEmailView)
    }
    
    // MARK: Methods
    
    func trigger(_ input: LoginInput) {
        switch input {
        case .checkEmail(let email):
            changeCheckEmailText(email)
        case .checkCode(let code):
            changeCheckCodeText(code)
        case .sendButton(let email):
            sendAuthEmail(email)
        case .showSendButton:
            showSendButton()
        case .backButton:
            changeIsEmailView()
        case .hideSendButton:
            state.isTyping = false
        case .authButton(let code, let device, let completion):
            sendAuthCode(code, device: device, completion: completion)
        }
    }
}

private extension LoginViewModel {
    
    func changeCheckEmailText(_ emailText: String) {
        state.checkEmailText
            = emailText.checkStyle(type: .email) ? "" : "올바르지 않은 이메일 형식입니다"
    }
    
    func changeCheckCodeText(_ codeText: String) {
        state.checkCodeText
            = codeText.checkStyle(type: .code)  ? "" : "6자리의 코드를 입력하세요(영문 대/소문자, 숫자)"
    }
    
    func sendAuthEmail(_ emailText: String) {
        if !emailText.checkStyle(type: .email) {
            print("올바르지 않아서 보낼 수 없어")
        } else {
            state.service.sendEmail(email: emailText)
            state.isEmailView = false
            UserDefaults.standard.set(state.isEmailView,
                                      forKey: "isEmailView")
        }
    }
    
    func sendAuthCode(_ codeText: String,
                      device: Device,
                      completion: @escaping () -> Void) {
        
        if !codeText.checkStyle(type: .code) {
            print("코드가 달라..")
        } else {
            state.service.requestAuthentication(code: codeText,
                                                device: device,
                                                completion: completion)
        }
    }
    
    func showSendButton() {
        state.isTyping = true
    }
    
    func hideSendButton() {
        state.isTyping = false
    }
    
    func changeIsEmailView() {
        state.isEmailView = true
        UserDefaults.standard.set(state.isEmailView,
                                  forKey: "isEmailView")
    }
    
}

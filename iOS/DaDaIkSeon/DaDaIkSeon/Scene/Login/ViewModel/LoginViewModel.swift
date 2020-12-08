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
        state = LoginState(service: service,
                           checkText: "",
                           isTyping: false,
                           isEmailView: true)
    }
    
    // MARK: Methods
    
    func trigger(_ input: LoginInput) {
        switch input {
        case .check(let email):
            changeCheckText(email)
        case .sendButtonInput(let email):
            sendAuthEmail(email)
        case .showSendButton:
            showSendButton()
        case .backButton:
            changeIsEmailView()
        case .hideSendButton:
            state.isTyping = false
        }
    }
}

private extension LoginViewModel {
    
    func changeCheckText(_ emailText: String) {
        state.checkText = checkEmailStyle(emailText) ? "" : "올바르지 않은 이메일 형식입니다"
    }
    
    func checkEmailStyle(_ emailText: String) -> Bool {
        return emailText.count > 3
    }
    
    func sendAuthEmail(_ emailText: String) {
        if !checkEmailStyle(emailText) {
            print("올바르지 않아서 보낼 수 없어")
        } else {
            state.service.sendEmail(email: emailText)
            state.isEmailView = false
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
    }
    
}

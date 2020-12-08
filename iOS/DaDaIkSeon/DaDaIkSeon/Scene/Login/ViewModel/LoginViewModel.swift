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
                           isEmail: false)
    }
    
    // MARK: Methods
    
    func trigger(_ input: LoginInput) {
        switch input {
        case .check(let email):
            checkEmailStyle(email)
        case .sendButtonInput:
            sendAuthEmail()
        case .showSendButton:
            showSendButton()
        case .hideSendButton:
            state.isEmail = false
        }
    }
}

private extension LoginViewModel {
    
    func checkEmailStyle(_ email: String) {
        state.checkText = email.count < 3 ? "올바르지 않은 이메일 형식입니다" : ""
    }
    
    func sendAuthEmail() {
        print("send")
    }
    
    func showSendButton() {
        state.isEmail = true
    }
    
    func hideSendButton() {
        state.isEmail = false
    }
    
}

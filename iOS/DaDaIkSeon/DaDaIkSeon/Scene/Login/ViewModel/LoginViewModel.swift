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
                           checkEmailText: "",
                           checkCodeText: "",
                           isTyping: false,
                           isEmailView: true)
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
        case .authButton(let code, let device):
            sendAuthCode(code, device: device)
        }
    }
}

private extension LoginViewModel {
    
    func changeCheckEmailText(_ emailText: String) {
        state.checkEmailText = checkEmailStyle(emailText) ? "" : "올바르지 않은 이메일 형식입니다"
    }
    
    func changeCheckCodeText(_ codeText: String) {
        state.checkCodeText = checkCodeStyle(codeText) ? "" : "6자리의 코드를 입력하세요(영문 대/소문자, 숫자)"
    }
    
    func checkEmailStyle(_ emailText: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailText)
    }
    
    func checkCodeStyle(_ codeText: String) -> Bool {
        let codeRegEx = "[A-Z0-9a-z]{6}"
        let codeTest = NSPredicate(format: "SELF MATCHES %@", codeRegEx)
        return codeTest.evaluate(with: codeText)
    }
    
    func sendAuthEmail(_ emailText: String) {
        if !checkEmailStyle(emailText) {
            print("올바르지 않아서 보낼 수 없어")
        } else {
            state.service.sendEmail(email: emailText)
            state.isEmailView = false
        }
    }
    
    func sendAuthCode(_ codeText: String, device: Device) {
        if !checkCodeStyle(codeText) {
            print("코드가 달라..")
        } else {
            state.service.requestAuthentication(code: codeText, device: device)
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


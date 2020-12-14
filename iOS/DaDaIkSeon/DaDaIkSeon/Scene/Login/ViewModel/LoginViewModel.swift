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
        case .sendButton(let email, let completion):
            sendAuthEmail(email, completion)
        case .showSendButton:
            showSendButton()
        case .backButton:
            changeIsEmailView(true)
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
    
    func sendAuthEmail(_ emailText: String,
                       _ completion: @escaping (String) -> Void) {
        
        if emailText.checkStyle(type: .email) {
            state.service.sendEmail(email: emailText) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .successSendEmail:
                        self.changeIsEmailView(false)
                        completion(ResultMessage.successSendEmailMessage.rawValue)
                    case .multideviceOff:
                        completion(ResultMessage.multideviceOffMessage.rawValue)
                    case .dataParsingError:
                        completion(ResultMessage.dataParsingError.rawValue)
                    case .networkError:
                        completion(ResultMessage.networkError.rawValue)
                    }
                }
            }
        }
    }
    
    func sendAuthCode(_ codeText: String,
                      device: Device,
                      completion: @escaping (String?) -> Void) {
        if codeText.checkStyle(type: .code) {
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
    
    func changeIsEmailView(_ isEmail: Bool) {
        state.isEmailView = isEmail
        UserDefaults.standard.set(state.isEmailView,
                                  forKey: "isEmailView")
    }
    
    enum ResultMessage: String {
        case successSendEmailMessage = "이메일로 인증코드를 전송했습니다"
        case multideviceOffMessage = "멀티 디바이스가 꺼져있어 등록이 불가능합니다"
        case dataParsingError = "Error"
        case networkError = "네트워크를 확인해주세요"
    }
}

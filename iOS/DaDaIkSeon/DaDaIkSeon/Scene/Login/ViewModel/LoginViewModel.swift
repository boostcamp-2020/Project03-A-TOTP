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
    
    func sendAuthEmail(_ emailText: String) {
        if emailText.checkStyle(type: .email) {
            state.service.sendEmail(email: emailText) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .successSendEmail:
                        print("하하하. 성공")
                        self.changeIsEmailView(false)
                    case .multideviceOff:
                        print("하하하 머ㅓㄹ티가 꺼졌어")
                    case .dataParsingError:
                        print("파싱이 안됐어...ㅋ")
                    case .networkError:
                        print("네트워크를 확인해주세요")
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
    
}

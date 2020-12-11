//
//  LoginUsecase.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

struct LoginState {
    var service: LoginServiceable
    var checkEmailText: String
    var checkCodeText: String
    var isTyping: Bool
    var isEmailView: Bool
}

enum LoginInput {
    case showSendButton
    case hideSendButton
    case backButton
    case checkCode(_ codeText: String)
    case checkEmail(_ emailText: String)
    case authButton(_ codeText: String, device: Device)
    case sendButton(_ emailText: String)
}

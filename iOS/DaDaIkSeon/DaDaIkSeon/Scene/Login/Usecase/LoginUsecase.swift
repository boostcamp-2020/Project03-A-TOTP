//
//  LoginUsecase.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

struct LoginState {
    var service: LoginServiceable
    var checkText: String
    var isTyping: Bool
    var isEmailView: Bool
}

enum LoginInput {
    case showSendButton
    case hideSendButton
    case backButton
    case check(_ emailText: String)
    case sendButtonInput(_ emailText: String)
}

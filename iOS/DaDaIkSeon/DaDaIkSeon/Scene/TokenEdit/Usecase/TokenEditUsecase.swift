//
//  TokenEditUsecase.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

struct TokenEditState {
    var service: TokenServiceable
    var qrCode: String?
    var token: Token
}

enum TokenEditInput {
    case addToken
    case changeName(_ name: String)
    case changeColor(_ name: String)
    case changeIcon(_ name: String)
}

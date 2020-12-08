//
//  TokenUsecase.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

struct TokenCellState {
    var service: TokenServiceable
    var token: Token
    var password: String
    var leftTime: String
    var timeAmount: Double
    var isShownEditView: Bool
}

enum TokenCellInput {
    case showEditView
    case hideEditView
}

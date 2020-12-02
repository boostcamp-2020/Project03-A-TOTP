//
//  TokenEditViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/02.
//

import Foundation

final class TokenEditViewModel: ViewModel {
    
    // MARK: Property
    
    @Published var state: TokenEditState
    
    init(service: TokenServiceable, token: Token?, qrCode: String?) {
        var defaultToken: Token
        if let token = token {
            defaultToken = token
        } else {
            defaultToken = Token(id: UUID(),
                                 key: qrCode,
                                 tokenName: nil,
                                 color: "mint",
                                 icon: "search")
        }
        state = TokenEditState(service: service,
                               qrCode: qrCode,
                               token: defaultToken)
    }
    
    // MARK: Methods
    
    func trigger(_ input: TokenEditInput) {
        switch input {
        case .addToken:
            state.service.add(token: state.token)
        case .changeColor(let color):
            state.token.color = color
        case .changeIcon(let icon):
            state.token.icon = icon
        case .changeName(let name):
            state.token.tokenName = name
        }
    }

}

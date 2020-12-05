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
    
    func trigger(_ input: TokenEditInput) {
        switch input {
        case .addToken:
            addToken()
        case .changeColor(let color):
            change(color: color)
        case .changeIcon(let icon):
            change(icon: icon)
        case .changeName(let name):
            change(name: name)
        }
    }
    
}

// MARK: Methods

private extension TokenEditViewModel {
    
    func addToken() {
        if state.qrCode == nil {
            state.service.update(token: state.token)
        } else {
            state.service.add(token: state.token)
        }
    }
    
    func change(color: String) {
        state.token.color = color
    }
    
    func change(icon: String) {
        state.token.icon = icon
    }
    
    func change(name: String) {
        state.token.tokenName = name
    }
    
}

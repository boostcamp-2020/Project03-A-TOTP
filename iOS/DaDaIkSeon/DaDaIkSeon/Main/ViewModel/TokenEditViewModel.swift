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
        state = TokenEditState(service: service,
                               qrCode: qrCode,
                               token: token)
    }
    
    // MARK: Methods
    
    func trigger(_ input: TokenEditInput) {
        switch input {
        case .addToken(let token):
            state.service.add(token: token)
        case .changeColor(let color):
            state.token?.color = color
        case .changeIcon(let icon):
            state.token?.icon = icon
        }
    }

}

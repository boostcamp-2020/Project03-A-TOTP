//
//  TokenViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation

struct TokenViewModel: Hashable {
    
    var token: Token
    
    var id: UUID {
        return UUID()
    }
    
    var key: String {
        guard let key = token.key else { return "" }
        return key
    }
    
    var tokenName: String {
        guard let tokenName = token.tokenName else { return "" }
        return tokenName
    }
    
    var color: String {
        guard let color = token.color else { return "" }
        return color
    }
    
    var icon: String {
        guard let icon = token.icon else { return "" }
        return icon
    }
    
    static func == (lhs: TokenViewModel, rhs: TokenViewModel) -> Bool {
        return lhs.id == rhs.id
            && lhs.key == rhs.key
            && lhs.tokenName == rhs.tokenName
            && lhs.color == rhs.color
            && lhs.icon == rhs.icon
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(key)
        hasher.combine(tokenName)
        hasher.combine(color)
        hasher.combine(icon)
    }
    
}

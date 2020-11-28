//
//  MainServiceable.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/29.
//

import Foundation

protocol MainServiceable {
    func loadTokens() -> [Token]
    func getFilteredTokens(text: String) -> [Token]
}

final class MainService: MainServiceable {
    
    var tokens: [Token] = []
    var filteredTokens: [Token] = []
    
    init() {
        tokens = loadTokens()
    }
    
    func loadTokens() -> [Token] {
        return Token.dummy()
    }
    
    func getFilteredTokens(text: String) -> [Token] {
        filteredTokens = tokens.filter { $0.tokenName?.contains(text) ?? false || text.isEmpty }
        return filteredTokens
    }
    
}

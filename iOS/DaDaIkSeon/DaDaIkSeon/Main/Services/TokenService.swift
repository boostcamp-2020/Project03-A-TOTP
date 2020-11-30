//
//  TokenService.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/29.
//

import Foundation

protocol TokenServiceable {
    func loadTokens() -> [Token]
    func getFilteredTokens(text: String) -> [Token]
    func getSearchingState() -> Bool
    func getSearchText() -> String
    func moveToken(id: UUID) -> [Token]
}

final class TokenService: TokenServiceable {
    
    // MARK: Property
    
    var tokens: [Token] = []
    var filteredTokens: [Token] = []
    var searchText = ""
    var isSearching = false
    
    // MARK: Init
    
    init() {
        tokens = loadTokens()
        filteredTokens = tokens
    }
    
    // MARK: Methods
    
    func loadTokens() -> [Token] {
        return Token.dummy()
    }
    
    func getFilteredTokens(text: String) -> [Token] {
        filteredTokens = tokens.filter {
            $0.tokenName?.contains(text) ?? false || text.isEmpty
        }
        return filteredTokens
    }
    
    func getSearchingState() -> Bool { isSearching }
    
    func getSearchText() -> String { searchText }
    
    func moveToken(id: UUID) -> [Token] {
        if let index = tokens.firstIndex(where: { $0.id == id }) {
            let token = tokens.remove(at: index)
            tokens.insert(token, at: 0)
        }
        filteredTokens = tokens
        return filteredTokens
    }
    
}

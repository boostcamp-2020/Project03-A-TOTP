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
    func getSearchingState() -> Bool
    func getSearchText() -> String
}

final class MainService: MainServiceable {
    
    // MARK: Property
    
    var tokens: [Token] = []
    var filteredTokens: [Token] = []
    var searchText = ""
    var isSearching = false
    
    // MARK: Init
    
    init() {
        tokens = loadTokens()
    }
    
    // MARK: Methods
    
    func loadTokens() -> [Token] {
        return Token.dummy()
    }
    
    func getFilteredTokens(text: String) -> [Token] {
        filteredTokens = tokens.filter {
            $0.tokenName?.contains(text) ?? false || text.isEmpty
        }
        isSearching = true
        return filteredTokens
    }
    
    func getSearchingState() -> Bool { isSearching }
    
    func getSearchText() -> String { searchText }
    
}

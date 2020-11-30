//
//  TokenService.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/29.
//

import Foundation


// Tokens(Token) Entity's CRUD

protocol TokenServiceable {
    
    func loadTokens() -> [Token]
    
    func getSearchingState() -> Bool
    func getSearchText() -> String
    func moveToken(id: UUID) -> Token
    func excludeMainCell() -> [Token]
    func setMainTokenIndex(id: UUID)
    func getMainToken() -> Token
    func token(id: UUID) -> Token?
    
    func getFilteredTokens(text: String) -> [Token]
}

final class TokenService: TokenServiceable {
    
    // MARK: Property
    
    var tokens: [Token] = []
    var mainTokenIndex: Int
    var filteredTokens: [Token] = []
    var searchText = ""
    var isSearching = false
    
    // MARK: Init
    
    init() {
        mainTokenIndex = 0 // 나중에 수정 - UserDefault.get
        tokens = loadTokens()
        filteredTokens = excludeMainCell()
    }
    
    // MARK: Methods
    
    func excludeMainCell() -> [Token] {
        (0..<tokens.count).filter {
            $0 != mainTokenIndex
        }.map {
            tokens[$0]
        }
    }
    
    // get으로 되어 있는 함수 이름 다 바꿔야 한다.
    // 서비스에서 실행되는 로직을 모두 뷰모델로 옮겨야 한다.
    // 서비스는 그저 데이터 CRUD만
    func token(id: UUID) -> Token? {
        tokens.first(where: { $0.id == id })
    }
    
    func getMainToken() -> Token {
        return tokens[mainTokenIndex]
    }
    
    func setMainTokenIndex(id: UUID) {
        if let index = tokens.firstIndex(where: { $0.id == id }) {
            mainTokenIndex = index
        }
    }
    
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
    
    func moveToken(id: UUID) -> Token {
        if let index = filteredTokens.firstIndex(where: { $0.id == id }) {
            mainTokenIndex = index
            return tokens[index]
        }
        return Token()
    }
    
}

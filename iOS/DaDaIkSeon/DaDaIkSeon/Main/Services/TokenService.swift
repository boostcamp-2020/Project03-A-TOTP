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
    func tokenList() -> [Token]
    func token(id: UUID) -> Token?
    func excludeMainCell() -> [Token]
    func updateMainTokenIndex(id: UUID)
    func mainToken() -> Token
    func removeTokens(_ idList: [UUID])
    func removeToken(_ id: UUID)
}

final class TokenService: TokenServiceable {
   
    // MARK: Property
    
    var tokens: [Token] = []
    var mainTokenIndex: Int
    
    // MARK: Init
    
    init() {
        mainTokenIndex = 0 // 나중에 수정 - UserDefault.get
        tokens = loadTokens()
    }
    
    // MARK: Methods
    
    func tokenList() -> [Token] {
        return tokens
    }
    
    func token(id: UUID) -> Token? {
        tokens.first(where: { $0.id == id })
    }
    
    func mainToken() -> Token {
        return tokens[mainTokenIndex]
    }
    
    func excludeMainCell() -> [Token] {
        (0..<tokens.count).filter {
            $0 != mainTokenIndex
        }.map {
            tokens[$0]
        }
    }
    
    func updateMainTokenIndex(id: UUID) {
        let lastMainIndex = mainTokenIndex
        if let index = tokens.firstIndex(where: { $0.id == id }) {
            mainTokenIndex = index
            tokens.insert(tokens.remove(at: lastMainIndex), at: 0)
        }
    }
    
    func loadTokens() -> [Token] {
        return Token.dummy()
    }
    
    func removeTokens(_ idList: [UUID]) {
        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
    }
    
    func removeToken(_ id: UUID) {
        tokens.removeAll(where: { $0.id == id })
    }
    
}

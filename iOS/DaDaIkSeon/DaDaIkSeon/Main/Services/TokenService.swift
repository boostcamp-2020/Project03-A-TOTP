//
//  TokenService.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/29.
//

import Foundation

// Tokens(Token) Entity's CRUD

protocol TokenServiceable {
    
    var tokenCount: Int { get }
    
    func loadTokens() -> [Token]
    func tokenList() -> [Token]
    func token(id: UUID) -> Token?
    func excludeMainCell() -> [Token]
    func updateMainTokenIndex(id: UUID)
    func mainToken() -> Token?
    func removeTokens(_ idList: [UUID])
    func removeToken(_ id: UUID)
}

final class TokenService: TokenServiceable {
    
    // MARK: Property
    
    private var tokens: [Token] = []
    private var mainTokenIndex: Int
    
    var tokenCount: Int {
        tokens.count
    }
    
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
    
    func mainToken() -> Token? {
        if tokenCount == 0 { return nil }
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
        tokens.insert(tokens.remove(at: mainTokenIndex), at: 0)
        if let index = tokens.firstIndex(where: { $0.id == id }) {
            mainTokenIndex = index
        }
    }
    
    func loadTokens() -> [Token] {
        return Token.dummy()
    }
    
    func removeTokens(_ idList: [UUID]) {
        
        
        // 삭제 대상이 메인 셀이면?
        // token에 메인을 제외한 첫 번째 셀을 메인으로 함
        // 얘가 0개가 되면 zero update
        // 
//        for index in tokens.indices
//        where tokens[index].id ==
//        {
//
//        }
        
        let mainTokenId = tokens[mainTokenIndex].id
        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
        for index in tokens.indices
        where tokens[index].id == mainTokenId {
            mainTokenIndex = index
        }
    }
    
    func removeToken(_ id: UUID) {
        tokens.removeAll(where: { $0.id == id })
    }
    
}

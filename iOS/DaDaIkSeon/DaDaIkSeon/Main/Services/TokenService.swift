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
    func add(token: Token)
    func excludeMainCell() -> [Token]
    func updateMainTokenIndex(id: UUID)
    func mainToken() -> Token?
    func removeTokens(_ idList: [UUID])
    func removeToken(_ id: UUID)
}

final class TokenService: TokenServiceable {
    
    // MARK: Property
    
    private var storageManager: StorageManager
    private var tokens: [Token] = []
    private var mainTokenIndex: Int
    
    var tokenCount: Int {
        tokens.count
    }
    
    // MARK: Init
    
    init(_ storageManager: StorageManager) {
        self.storageManager = storageManager
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
    
    func add(token: Token) {
        tokens.append(token)
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
      
        let oldTokenId = tokens[mainTokenIndex].id

        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
        for index in tokens.indices // 남아있는 토큰 중에 메인이 있으면 그 인덱스를 메인 인덱스로
        where tokens[index].id == oldTokenId {
            mainTokenIndex = index
        }
        if idList.contains(oldTokenId) { // 삭제 대상 중에 메인이 있으면 0번을 메인 인덱스로
            mainTokenIndex = 0
        }
        
    }
    
    func removeToken(_ id: UUID) {
        tokens.removeAll(where: { $0.id == id })
    }
    
}

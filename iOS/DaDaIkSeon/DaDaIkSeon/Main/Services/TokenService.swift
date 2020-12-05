//
//  TokenService.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/29.
//

import Foundation

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
    
    func token(id: UUID) -> Token? {
        tokens.first(where: { $0.id == id })
    }
    
    func tokenList() -> [Token] {
        return tokens
    }
    
    func loadTokens() -> [Token] {
        return storageManager.loadTokens() ?? []
    }
    
    func add(token: Token) {
        tokens.append(token)
        _ = storageManager.storeTokens(tokens)
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
    
    func updateMainToken(id: UUID) {
        tokens.insert(tokens.remove(at: mainTokenIndex), at: 0)
        if let index = tokens.firstIndex(where: { $0.id == id }) {
            mainTokenIndex = index
        }
    }
    
    func removeTokens(_ idList: [UUID]) {
        let oldTokenId = tokens[mainTokenIndex].id

        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
        
        // 남아있는 토큰 중에 메인이 있으면 그 인덱스를 메인 인덱스로
        for index in tokens.indices where tokens[index].id == oldTokenId {
            mainTokenIndex = index
        }
        
        // 삭제 대상 중에 메인이 있으면 0번을 메인 인덱스로
        if idList.contains(oldTokenId) {
            mainTokenIndex = 0
        }
        
        _ = storageManager.storeTokens(tokens)
    }
    
    func removeToken(_ id: UUID) {
        tokens.removeAll(where: { $0.id == id })
    }
    
}

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
    
    var tokenCount: Int {
        tokens.count
    }
    
    // MARK: Init
    
    init(_ storageManager: StorageManager) {
        self.storageManager = storageManager
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
        var token = token
        if tokens.count == 0 {
            token.isMain = true
        }
        tokens.append(token)
        _ = storageManager.storeTokens(tokens)
    }
  
    func mainToken() -> Token? {
        var token: Token?
        tokens.forEach {
            if $0.isMain == true {
                token = $0
                return
            }
        }
        return token
    }
    
    func excludeMainCell() -> [Token] {
        tokens.filter {
            guard let isMain = $0.isMain else { return true }
            return !isMain
        }
    }
    
    func updateMainToken(id: UUID) {
        guard let mainTokenIndex = tokens.firstIndex(where: {
            guard let isMain = $0.isMain else { return false }
            return isMain
        }) else { return }
        var oldMainToken = tokens.remove(at: mainTokenIndex)
        oldMainToken.isMain = false
        tokens.insert(oldMainToken, at: 0)
        if let index = tokens.firstIndex(where: { $0.id == id }) {
            tokens[index].isMain = true
        }
    }
    
    func removeTokens(_ idList: [UUID]) {
        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
        if tokens.count == 0 { return }
        updateMainWithFirstToken()
        _ = storageManager.storeTokens(tokens)
    }
    
    func removeToken(_ id: UUID) {
        tokens.removeAll(where: { $0.id == id })
        _ = storageManager.storeTokens(tokens)
    }
    
}

extension TokenService {
    
    func updateMainWithFirstToken() {
        if nil !=  mainToken() {
            return
        } else {
            tokens[0].isMain = true
        }
    }
    
}

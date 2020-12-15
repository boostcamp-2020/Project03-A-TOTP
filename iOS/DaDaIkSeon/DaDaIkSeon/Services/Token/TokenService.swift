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
        for index in tokens.indices where tokens[index].isMain == true { return }
        if tokens.count == 0 { return }
        tokens[0].isMain = true
        _ = storageManager.storeTokens(tokens)
    }
    
    // MARK: Methods
    
    func token(id: UUID) -> Token? {
        tokens.first(where: { $0.id == id })
    }
    
    func tokenList() -> [Token] {
        return tokens
    }
    
    func loadTokens() -> [Token] {
        // 암호화
        var encryptedTokens = [Token]()
        
        tokens.forEach {
            var token = $0
            if let password = BackupPasswordManager().loadPassword() {
                if let key = token.key {
                    do {
                        token.key = try TokenCryptoManager(password).encrypt(with: key)
                    } catch {
                        print(error)
                    }
                }
            } else {
                print("백업 비밀번호가 없다!")
            }
            encryptedTokens.append(token)
        }
        TokenNetworkManager.shared.syncTokens(lastUpdate: "", tokens: encryptedTokens) { result in
            
            
            
        }
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
    
    func update(token: Token) {
        guard let index = tokens.firstIndex(where: { $0.id == token.id }) else { return }
        tokens[index] = token
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
        guard let oldMainTokenIndex = tokens.firstIndex(where: {
            guard let isMain = $0.isMain else { return false }
            return isMain
        }) else { return }
        tokens[oldMainTokenIndex].isMain = false
        tokens.move(fromOffsets: IndexSet(integer: oldMainTokenIndex), toOffset: 0)
        if let index = tokens.firstIndex(where: { $0.id == id }) {
            tokens[index].isMain = true
        }
        _ = storageManager.storeTokens(tokens)
    }
    
    func removeTokens(_ idList: [UUID]) {
        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
        _ = storageManager.storeTokens(tokens)
        if tokens.count == 0 { return }
        updateMainWithFirstToken()
    }
    
    func removeToken(_ id: UUID) {
        tokens.removeAll(where: { $0.id == id })
        _ = storageManager.storeTokens(tokens)
    }
    
    func updateTokenPosition(from: Int, target: Int) {
        tokens.move(fromOffsets: IndexSet(integer: from),
                      toOffset: target > from ? target + 1 : target)
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

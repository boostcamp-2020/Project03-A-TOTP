//
//  MockTokenService.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/05.
//

import Foundation

final class MockTokenService: TokenServiceable {
    func decryptTokenKeys(tokens: [Token], password: String?) -> MainNetworkResult {
        return .failedEncryption
    }
    
    
    func refreshTokens(updateView: @escaping (MainNetworkResult) -> Void) {
        //
    }
    
    // MARK: Property
    
    private var tokens: [Token] = []
    
    var tokenCount: Int {
        tokens.count
    }
    
    // MARK: Init
    
    init() {
        tokens = loadTokens()
    }
    
    // MARK: Methods
    
    func token(id: String) -> Token? {
        tokens.first(where: { $0.id == id })
    }
    
    func tokenList() -> [Token] {
        return tokens
    }
    
    func loadTokens() -> [Token] {
        return Token.dummy()
    }
    
    func add(token: Token) {
        var token = token
        if tokens.count == 0 {
            token.isMain = true
        }
        tokens.append(token)
    }
    
    func update(token: Token) {
        guard let index = tokens.firstIndex(where: { $0.id == token.id }) else { return }
        tokens[index] = token
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
    
    func updateMainToken(id: String) { // main id가 없는 경우 에러다.
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
    
    func removeTokens(_ idList: [String]) {
        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
        if tokens.count == 0 { return }
        updateMainWithFirstToken()
    }
    
    func removeToken(_ id: String) {
        tokens.removeAll(where: { $0.id == id })
        if tokens.count == 0 { return }
        updateMainWithFirstToken()
    }
    
    func updateTokenPosition(from: Int, target: Int) {
        tokens.move(fromOffsets: IndexSet(integer: from),
                      toOffset: target > from ? target + 1 : target)
    }
    
}

extension MockTokenService {
    
    func updateMainWithFirstToken() {
        if nil !=  mainToken() {
            return
        } else {
            tokens[0].isMain = true
        }
    }
    
}

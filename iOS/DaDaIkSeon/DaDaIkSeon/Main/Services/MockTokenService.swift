//
//  MockTokenService.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/05.
//

import Foundation

final class MockTokenService: TokenServiceable {
    
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
    
    func token(id: UUID) -> Token? {
        tokens.first(where: { $0.id == id })
    }
    
    func tokenList() -> [Token] {
        return tokens
    }
    
    func loadTokens() -> [Token] {
        return Token.dummy()
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

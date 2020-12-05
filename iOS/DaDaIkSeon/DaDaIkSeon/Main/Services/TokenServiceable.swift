//
//  TokenServiceable.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/05.
//

import Foundation

protocol TokenServiceable {
    
    var tokenCount: Int { get }
    
    func loadTokens() -> [Token]
    
    func token(id: UUID) -> Token?
    
    func tokenList() -> [Token]
    
    func add(token: Token)
    
    func update(token: Token)
    
    func mainToken() -> Token?
    
    func excludeMainCell() -> [Token]
    
    func updateMainToken(id: UUID)
    
    func removeTokens(_ idList: [UUID])
    
    func removeToken(_ id: UUID)
    
}

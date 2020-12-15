//
//  TokenServiceable.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/05.
//

import Foundation

protocol TokenServiceable {
    
    var tokenCount: Int { get }
    
    func refreshTokens(updateView: @escaping (MainNetworkResult) -> Void)
    
    func token(id: String) -> Token?
    
    func tokenList() -> [Token]
    
    func add(token: Token)
    
    func update(token: Token)
    
    func mainToken() -> Token?
    
    func excludeMainCell() -> [Token]
    
    func updateMainToken(id: String)
    
    func removeTokens(_ idList: [String])
    
    func removeToken(_ id: String)
    
    func updateTokenPosition(from: Int, target: Int)
    
}

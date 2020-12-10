//
//  TokenNetworkManager.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

final class TokenNetworkManager: Requestable {
    
    typealias NetworkData = ResponseArray<Token>
    
    var tokenEndpoint: TokenEndpoint = .get
    
    func loadToken(completion: @escaping ([Token]) -> Void) {
        tokenEndpoint = .get
        request(tokenEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                guard let tokens = data.responseResult.data else { return }
                completion(tokens)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
            }
        }
    }

    func createToken(lastUpdate: String,
                     token: Token,
                     completion: @escaping() -> Void) {
        
        tokenEndpoint = .postToken(lastUpdate: lastUpdate, tokens: [token])
        request(tokenEndpoint) { result in
            switch result {
            case .networkSuccess:
                completion()
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
            }
        }
    }
    
    func syncTokens(lastUpdate: String,
                    tokens: [Token],
                    completion: @escaping([Token]) -> Void) {
        
        tokenEndpoint = .putTokens(lastUpdate: lastUpdate, tokens: tokens)
        
        request(tokenEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                guard let tokens = data.responseResult.data else { return }
                completion(tokens)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
            }
        }
    }
    
    
}

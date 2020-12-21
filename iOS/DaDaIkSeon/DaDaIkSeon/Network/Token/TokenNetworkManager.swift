//
//  TokenNetworkManager.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

struct TokenNetworkType: Codable {
    var lastUpdate: String?
    var tokens: [Token]?
}

final class TokenNetworkManager: Requestable {
    
    typealias NetworkData = ResponseObject<TokenNetworkType>
    
    static let shared = TokenNetworkManager()
    private init() {}
    
    private var tokenEndpoint: TokenEndpoint = .get
    
    // 최초 한 번만 실행 - 그 이후에는 항상 싱크 비교가 되어야 한다.
    func load(completion: @escaping (MainNetworkResult) -> Void) {
        
        tokenEndpoint = .get
        request(tokenEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                guard let resultData = data.responseResult.data else {
                    completion(.parsingError)
                    return
                }
                completion(.successLoad(resultData))
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
            }
        }
    }

    func syncTokens(lastUpdate: String,
                    tokens: [Token],
                    completion: @escaping( MainNetworkResult ) -> Void) {
        
        tokenEndpoint = .putAll(lastUpdate: lastUpdate,
                                tokens: tokens)
        request(tokenEndpoint) { result in
            switch result {
            case .networkSuccess:
                completion(.successSync)
            case .networkError(let error):
                print(error)
                completion(.parsingError)
            case .networkFail:
                completion(.networkError)
            }
        }
    }
    
    func create(token: Token,
                completion: @escaping() -> Void) {
        tokenEndpoint = .postOne(token: token)
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
    
    func modify(token: Token,
                completion: @escaping() -> Void) {
        
        tokenEndpoint = .patch(token: token)
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
    
    func delete(id: String,
                completion: @escaping() -> Void) {
        
        tokenEndpoint = .delete(id: id)
        
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
    
}

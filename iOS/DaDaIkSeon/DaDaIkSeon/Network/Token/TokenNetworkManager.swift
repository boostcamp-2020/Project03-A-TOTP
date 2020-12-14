//
//  TokenNetworkManager.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

final class TokenNetworkManager: Requestable {
    
    typealias NetworkData = ResponseArray<Token>
    
    static let shared = TokenNetworkManager()
    private init() {}
    
    private var tokenEndpoint: TokenEndpoint = .get
    
    // 최초 한 번만 실행 - 그 이후에는 항상 싱크 비교가 되어야 한다. 
    func load(completion: @escaping ([Token]) -> Void) {
        
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

    func create(lastUpdate: String,
                token: Token,
                completion: @escaping() -> Void) {
        
        tokenEndpoint = .postOne(lastUpdate: lastUpdate,
                                 tokens: [token])
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
        
        tokenEndpoint = .putAll(lastUpdate: lastUpdate,
                                tokens: tokens)
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
    
    // id는 UUID인데 String으로 언제 바꿔주어야할까?
    func modify(id: String,
                token: Token,
                completion: @escaping() -> Void) {
        
        tokenEndpoint = .patch(id: id,
                               token: token)
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

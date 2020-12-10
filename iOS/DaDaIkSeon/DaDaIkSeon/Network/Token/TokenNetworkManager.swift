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

}

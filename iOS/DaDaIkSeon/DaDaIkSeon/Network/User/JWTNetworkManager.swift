//
//  JWTNetworkManager.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

final class JWTNetworkManager: Requestable {
    
    typealias NetworkData = ResponseObject<String>
    
    var userEndpoint: UserEndpoint = .get
    
    func getJWTToken(code: String,
                     email: String,
                     device: Device,
                     completion: @escaping(String) -> Void) {
        
        userEndpoint = .postCode(code: code,
                                 email: email,
                                 device: device)
        
        request(userEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                guard let jwtToken = data.responseResult.data else { return }
                completion(jwtToken)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
            }
        }
    }
    
}

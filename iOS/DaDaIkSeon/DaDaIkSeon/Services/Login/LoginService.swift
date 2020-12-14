//
//  LoginService.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

protocol LoginServiceable {
    func sendEmail(email: String,
                   completion: @escaping (LoginNetworkResult) -> Void)
    func requestAuthentication(code: String,
                               device: Device,
                               completion: @escaping (String?) -> Void)
}

final class LoginService: LoginServiceable {
    
    var user = DDISUser(email: nil,
                        device: nil,
                        multiDevice: nil)
    
    func sendEmail(email: String,
                   completion: @escaping (LoginNetworkResult) -> Void) {
        UserNetworkManager.shared.sendEmail(email: email) { [weak self] result in
            guard let self = self else { return }
            self.user.email = email
            completion(result)
        }
    }
    
    func requestAuthentication(code: String,
                               device: Device,
                               completion: @escaping (String?) -> Void) {
        
        guard let email = user.email else { return }
        
        JWTNetworkManager.shared.getJWTToken(code: code,
                                             email: email,
                                             device: device) { jwtToken in
            if let jwtToken = jwtToken {
                JWTTokenStoreManager().store(jwtToken)
            }
            completion(jwtToken)
        }
    }
    
}

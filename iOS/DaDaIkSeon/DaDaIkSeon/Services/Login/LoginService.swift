//
//  LoginService.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

protocol LoginServiceable {
    func sendEmail(email: String)
    func requestAuthentication(code: String, device: Device)
}

final class LoginService: LoginServiceable {
    
    var loginNetwork: UserNetworkManager
    var user = DDISUser(email: nil, device: nil, multiDevice: nil)
    let jwtTokenNetwork = JWTNetworkManager()
    
    init(network: UserNetworkManager) {
        loginNetwork = network
    }
    
    func sendEmail(email: String) {
        loginNetwork.sendEmail(email: email) { [weak self] in
            guard let self = self else { return }
            self.user.email = email
        }
    }
    
    func requestAuthentication(code: String, device: Device) {
        guard let email = user.email else { return }
        
        jwtTokenNetwork.getJWTToken(code: code,
                                    email: email,
                                    device: device) { jwtToken in
            print("토큰:\(jwtToken)") // 키체인에 저장해야함
        }
        
    }
    
}

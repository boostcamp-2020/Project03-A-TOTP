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
    
    var user = DDISUser(email: nil, device: nil, multiDevice: nil)
    
    func sendEmail(email: String) {
        UserNetworkManager.shared.sendEmail(email: email) { [weak self] in
            guard let self = self else { return }
            self.user.email = email
        }
    }
    
    func requestAuthentication(code: String, device: Device) {
        guard let email = user.email else { return }
        JWTNetworkManager.shared.getJWTToken(code: code,
                                    email: email,
                                    device: device) { jwtToken in
            print("토큰:\(jwtToken)") // 키체인에 저장해야함
            UserDefaults.standard.set(jwtToken, forKey: "JWTToken") // 데이터 저장
        }
        
    }
    
}

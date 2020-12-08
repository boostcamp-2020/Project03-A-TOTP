//
//  LoginService.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

protocol LoginServiceable {
    func sendEmail(email: String)
    func requestAuthentication(code: String)
}

final class LoginService: LoginServiceable {
    
    func sendEmail(email: String) {
        print("\(email) 에게 인증 요청을 보냈어요")
    }
    
    func requestAuthentication(code: String) {
        print("\(code) 코드 생성")
        createDDISUser()
    }
    
}

private extension LoginService {
    
    func createDDISUser() {
        print("유저를 생성했어요")
    }
    
}

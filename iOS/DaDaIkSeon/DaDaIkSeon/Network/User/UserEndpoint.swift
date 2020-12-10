//
//  UserEndpoint.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

enum UserEndpoint {
    case get
    case postEmail(email: String)
    case postCode(code: String, email: String, device: Device)
}

extension UserEndpoint: EndpointType {
    
    var path: String {
        let basePath = baseUrl
        
        switch self {
        case .get:
            return basePath
        case .postEmail:
            return basePath + "/email"
        case .postCode:
            return basePath + "/confirm-email"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .GET
        case .postEmail, .postCode:
            return .POST
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .get:
            return nil
        case .postEmail(let email):
            return ["email": email]
        case .postCode(let code, let email, let device):
            return [
                "code": code,
                "email": email,
                "device": device
            ]
        }
    }
    
}

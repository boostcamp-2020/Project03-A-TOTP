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
    case patchEmail(email: String)
    case patchBackup(isBackup: Bool, udid: String)
    case patchMultiDevice(isMultiDevice: Bool)
//    case
//
}

extension UserEndpoint: EndpointType {
    
    var path: String {
        let basePath = baseUrl
        
        switch self {
        case .get:
            return basePath
        case .postEmail, .patchEmail:
            return basePath + "/email"
        case .postCode:
            return basePath + "/confirm-email"
        case .patchBackup(let id, _):
            return basePath + "/backup/\(id)"
        case .patchMultiDevice:
            return basePath + "/multi"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .GET
        case .postEmail, .postCode:
            return .POST
        case .patchEmail, .patchBackup, .patchMultiDevice:
            return .PATCH
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .get:
            return nil
        case .postEmail(let email), .patchEmail(let email):
            return ["email": email]
        case .postCode(let code, let email, let device):
            return [
                "code": code,
                "email": email,
                "device": device
            ]
        case .patchBackup(_, let backup):
            return ["backup": backup]
        case .patchMultiDevice(let multiDevice):
            return ["multiDevice": multiDevice]
        }
    }
    
}

//
//  SettingEndpoint.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/11.
//

import Foundation

enum SettingEndpoint {
    case patchEmail(email: String)
    case patchBackup(isBackup: Bool, udid: String)
    case patchMultiDevice(isMultiDevice: Bool)
}

extension SettingEndpoint: EndpointType {
    
    var path: String {
        let basePath = baseUrl + "/app/user"
        
        switch self {
        case .patchEmail:
            return basePath + "/email"
        case .patchBackup(let id, _):
            return basePath + "/backup/\(id)"
        case .patchMultiDevice:
            return basePath + "/multi"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .patchEmail, .patchBackup, .patchMultiDevice:
            return .PATCH
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .patchEmail(let email):
            return ["email": email]
        case .patchBackup(_, let backup):
            return ["backup": backup]
        case .patchMultiDevice(let multiDevice):
            return ["multiDevice": multiDevice]
        
        }
    }
    
}

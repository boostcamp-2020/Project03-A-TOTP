//
//  SettingEndpoint.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/11.
//

import Foundation

enum SettingEndpoint {
    case patchEmail(email: String)
    case patchBackup(udid: String, isBackup: Bool)
    case patchMultiDevice(isMultiDevice: Bool)
    case patchDevice(udid: String, name: String)
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
        case .patchDevice(let id, _):
            return basePath + "/device/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .patchEmail, .patchBackup, .patchMultiDevice, .patchDevice:
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
        case .patchDevice(_, let name):
            return ["name": name]
        }
    }
    
}

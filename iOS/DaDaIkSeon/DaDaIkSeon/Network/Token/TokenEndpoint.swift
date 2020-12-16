//
//  TokenEndpoint.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

enum TokenEndpoint {
    case get
    case postOne(token: Token)
    case putAll(lastUpdate: String, tokens: [Token])
    case patch(token: Token)
    case delete(id: String)
}

extension TokenEndpoint: EndpointType {
    
    var path: String {
        let basePath = baseUrl + "/token"
        
        switch self {
        case .get, .postOne, .putAll:
            return basePath
        case .patch(let token):
            return basePath + "/\(token.id)"
        case.delete(let id):
            return basePath + "/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .GET
        case .postOne:
            return .POST
        case .putAll:
            return .PUT
        case .patch:
            return .PATCH
        case .delete:
            return .DELETE
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .get, .delete:
            return nil
        case .postOne(let token):
            let dicArray = [token].map { convertToDictionary(token: $0) }
            return [
                "tokens": dicArray
            ]
        case .putAll(let lastUpdate, let tokens):
            let dicArray = tokens.map { convertToDictionary(token: $0) }
            return [
                "lastUpdate": lastUpdate,
                "tokens": dicArray
            ]
        case .patch(let token):
            return  [
                "token": [
                    "id": token.id,
                    "key": token.key ?? "",
                    "name": token.name ?? "",
                    "color": token.color ?? "",
                    "icon": token.icon ?? "",
                    "is_Main": token.isMain ?? false
                ]
            ]
        }
    }
    
    func convertToDictionary(token: Token) -> [String: Any] {
        return ["id": token.id,
                "key": token.key ?? "",
                "name": token.name ?? "",
                "color": token.color ?? "",
                "icon": token.icon ?? "",
                "is_Main": token.isMain ?? false]
    }
    
}

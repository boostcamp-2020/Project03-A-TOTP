//
//  TokenEndpoint.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

enum TokenEndpoint {
    case get
    case postToken(lastUpdate: String, tokens: [Token])
    case putTokens(lastUpdate: String, tokens: [Token])
    case patch(id: String, token: Token)
    case delete(id: String)
}

extension TokenEndpoint: EndpointType {
    
    var path: String {
        switch self {
        case .get, .postToken, .putTokens:
            return baseUrl
        case .patch(let id, _), .delete(let id):
            return baseUrl + "\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .GET
        case .postToken:
            return .POST
        case .putTokens:
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
        case .postToken(let lastUpdate, let tokens),
             .putTokens(let lastUpdate, let tokens):
            return [
                "lastUpdate": lastUpdate,
                "tokens": tokens
            ]
        case .patch(let id, let token):
            return  [
                "id": id,
                "token": token
            ]
        }
    }
    
}

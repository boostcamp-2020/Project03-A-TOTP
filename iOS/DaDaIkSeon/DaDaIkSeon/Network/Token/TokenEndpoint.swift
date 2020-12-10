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
}

extension TokenEndpoint: EndpointType {
    
    var path: String {
        switch self {
        case .get, .postToken:
            return baseUrl
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .GET
        case .postToken:
            return .POST
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .get:
            return nil
        case .postToken(let lastUpdate, let tokens):
            return [
                "lastUpdate": lastUpdate,
                "tokens": tokens
            ]
        }
    }
    
}

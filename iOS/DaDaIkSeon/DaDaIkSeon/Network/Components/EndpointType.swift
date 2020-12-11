//
//  EndpointType.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

protocol EndpointType {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [String: Any]? { get }
}

extension EndpointType {
    var baseUrl: String {
        return "https://dadaikseon.com/api/app"
    }
}


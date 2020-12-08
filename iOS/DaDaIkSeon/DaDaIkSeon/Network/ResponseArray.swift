//
//  ResponseArray.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

struct ResponseArray<T: Codable>: Codable {
    var message: String?
    var data: [T]?
}

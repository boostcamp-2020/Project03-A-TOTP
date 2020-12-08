//
//  Device.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

struct Device: Codable, Equatable {
    
    var name: String?
    var udid: String?
    var modelName: String?
    
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.name == rhs.name
            && lhs.udid == rhs.udid
            && lhs.modelName == rhs.modelName
    }
    
    static func dummy() -> [Device] {
        [
            Device(name: "jjm", udid: "a", modelName: "아이폰"),
            Device(name: "kjg", udid: "b", modelName: "갤럭시")
        ]
    }
    
}

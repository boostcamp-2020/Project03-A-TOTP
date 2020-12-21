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
    var backup: Bool?
    var lastUpdate: String?
    
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.name == rhs.name
            && lhs.udid == rhs.udid
            && lhs.modelName == rhs.modelName
            && lhs.backup == rhs.backup
            && lhs.lastUpdate == rhs.lastUpdate
    }
    
    static func dummy() -> [Device] {
        [
            Device(name: "jjm",
                   udid: "8D30104D-91D8-4503-B55B-C1063701AD6F",
                   modelName: "아이폰",
                   backup: false,
                   lastUpdate: "2020-11-21"),
            Device(name: "kjg",
                   udid: "70C3A0F0-1491-43C6-8B1C-59F0E989A0A8",
                   modelName: "갤럭시",
                   backup: false,
                   lastUpdate: "2020-11-23")
        ]
    }
    
}

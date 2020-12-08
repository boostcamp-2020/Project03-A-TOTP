//
//  User.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

struct DDISUser: Codable, Equatable  {
    var email: String?
    var device: [Device]?
    var backup: Bool?
    var multiDevice: Bool?
    var lastUpdate: String?
    
    static func == (lhs: DDISUser, rhs: DDISUser) -> Bool {
        return lhs.email == rhs.email
            && lhs.device == rhs.device
            && lhs.backup == rhs.backup
            && lhs.multiDevice == rhs.multiDevice
            && lhs.lastUpdate == rhs.lastUpdate
    }
    
    static func dummy() -> DDISUser {
        DDISUser(email: "jjm@dadaikseon.com",
                 device: Device.dummy(),
                 backup: false,
                 multiDevice: false,
                 lastUpdate: "")
    }
}

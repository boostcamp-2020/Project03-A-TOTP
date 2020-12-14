//
//  User.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

struct DDISUser: Codable, Equatable {
    
    var email: String?
    var device: Device?
    var devices: [Device]?
    var multiDevice: Bool?
    
    static func == (lhs: DDISUser, rhs: DDISUser) -> Bool {
        return lhs.email == rhs.email
            && lhs.device == rhs.device
            && lhs.multiDevice == rhs.multiDevice
    }
    
    // 혹시 모르니까 유저 디폴트로 저장해놓을까?
    // 이메일이랑 
    static func placeHoler() -> DDISUser {
        DDISUser(email: "jjm@dadaikseon.com",
                 devices: Device.dummy(),
                 multiDevice: false)
    }
    
}

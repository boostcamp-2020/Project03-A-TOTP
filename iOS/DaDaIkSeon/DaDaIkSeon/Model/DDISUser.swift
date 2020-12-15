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

struct DDISUserCache {
    static let key = "userCache"
    static func save(_ value: DDISUser) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    static func get() -> DDISUser? {
        if let objects = UserDefaults.standard.value(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(DDISUser.self,
                                                        from: objects) as DDISUser {
                return objectsDecoded
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

//
//  TOTPGenerator.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/28.
//

import Foundation
import SwiftOTP

class TOTPGenerator {
    
    static func generate(from key: String) -> String? {
        
        guard let keyData = base32DecodeToData(key) else {
            return nil
        }
        
        guard let totp = TOTP(
                secret: keyData,
                digits: 6,
                timeInterval: 30,
                algorithm: .sha1) else {
            return nil
        }
        guard let password = totp.generate(
                secondsPast1970: Int(Date().timeIntervalSince1970))
        else {
            return nil
        }
        return password
    }
    
    static func extractKey(from urlOfQrcode: String) -> String? {
        let items = URLComponents(string: urlOfQrcode)?.queryItems
        if let items = items {
            for index in items.indices {
                if items[index].name == "secret" {
                    return items[index].value
                }
            }
        }
        return nil
    }
    
}

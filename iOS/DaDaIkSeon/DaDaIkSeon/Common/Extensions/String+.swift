//
//  String+.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/12.
//

import Foundation

extension String {
    
    enum RegExType: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case code = "[A-Z0-9a-z]{6}"
        case password = "[A-Z0-9a-z]{6,15}"
    }
    
    func checkStyle(type: RegExType) -> Bool {
        let regEx = type.rawValue
        let test = NSPredicate(format: "SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    
}

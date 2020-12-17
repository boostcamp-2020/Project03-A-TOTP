//
//  Date+.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/16.
//

import Foundation

extension Date {
    
    func dateFormatToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.string(from: self)
    }

}

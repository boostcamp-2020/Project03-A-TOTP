//
//  TOTPToken.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import Foundation

struct TOTPToken: Identifiable {
    var id = UUID()
    var key: String?
    var tokenName: String?
    var color: String?
    var icon: String?
}

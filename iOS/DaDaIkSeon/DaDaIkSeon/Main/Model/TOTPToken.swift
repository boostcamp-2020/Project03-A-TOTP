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

    static func dummy() -> [TOTPToken] {
        [
            TOTPToken(key: "6UAOpz+x3dsNrQ=="),
            TOTPToken(key: "6UAOpz+x3dsNrQ=="),
            TOTPToken(key: "6UAOpz+x3dsNrQ=="),
            TOTPToken(key: "6UAOpz+x3dsNrQ=="),
            TOTPToken(key: "6UAOpz+x3dsNrQ==")
        ]
    }
}

// 필요하면 추가

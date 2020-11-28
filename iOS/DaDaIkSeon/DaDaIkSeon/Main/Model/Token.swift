//
//  Token.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import Foundation

struct Token: Identifiable {
    var id = UUID()
    var key: String?
    var tokenName: String?
    var color: String?
    var icon: String?
    
    static func dummy() -> [Token] {
        [
            Token(id: UUID(),
                  key: "WEJ3NLTTYHF4XVXG",
                  tokenName: "배고파",
                  color: "pink",
                  icon: nil),
            Token(id: UUID(),
                  key: "nv66p42pcv4f2fbgetakq6clottovx7z",
                  tokenName: "네이버2",
                  color: "salmon",
                  icon: nil),
            Token(id: UUID(),
                  key: "WEJ3NLTTYHF4XVXG",
                  tokenName: "네이버",
                  color: "navy",
                  icon: nil),
            Token(id: UUID(),
                  key: "6UAOpz+x3dsNrQ==",
                  tokenName: "구글",
                  color: "blue",
                  icon: nil),
            Token(id: UUID(),
                  key: "nv66p42pcv4f2fbgetakq6clottovx7z",
                  tokenName: "배아파",
                  color: "brown",
                  icon: nil),
            Token(id: UUID(),
                  key: "nv66p42pcv4f2fbgetakq6clottovx7z",
                  tokenName: "배아파",
                  color: "mint",
                  icon: nil)
        ]
    }
}

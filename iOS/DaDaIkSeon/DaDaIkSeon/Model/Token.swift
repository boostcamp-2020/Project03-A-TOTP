//
//  Token.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import Foundation

struct Token: Identifiable, Codable, Equatable {
    
    var id = UUID().uuidString
    var key: String?
    var name: String?
    var color: String?
    var icon: String?
    var isMain: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, color, icon
        case isMain = "is_Main"
    }
    
    static func == (lhs: Token, rhs: Token) -> Bool {
        lhs.id == rhs.id
    }
    
    static func dummy() -> [Token] {
        [
            Token(id: UUID().uuidString,
                  key: "WEJ3NLTTYHF4XVXG",
                  name: "게임",
                  color: "pink",
                  icon: "game",
                  isMain: true),
            Token(id: UUID().uuidString,
                  key: "nv66p42pcv4f2fbgetakq6clottovx7z",
                  name: "쇼핑",
                  color: "salmon",
                  icon: "creditcard",
                  isMain: false),
            Token(id: UUID().uuidString,
                  key: "WEJ3NLTTYHF4XVXG",
                  name: "애플",
                  color: "navy",
                  icon: "heart",
                  isMain: false),
            Token(id: UUID().uuidString,
                  key: "WEJ3NLTTYHF4XVXG",
                  name: "게임2",
                  color: "blue",
                  icon: "globe",
                  isMain: false),
            Token(id: UUID().uuidString,
                  key: "nv66p42pcv4f2fbgetakq6clottovx7z",
                  name: "검색",
                  color: "brown",
                  icon: "pin",
                  isMain: false),
            Token(id: UUID().uuidString,
                  key: "nv66p42pcv4f2fbgetakq6clottovx7z",
                  name: "음악",
                  color: "mint",
                  icon: "musicNote",
                  isMain: false)
        ]
    }
    
}

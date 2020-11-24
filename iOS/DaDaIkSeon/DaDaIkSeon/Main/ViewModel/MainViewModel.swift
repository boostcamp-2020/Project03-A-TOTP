//
//  MainViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var tokens: [TOTPToken] = []
    
    init() {
        tokens = fetchTokens()
    }
    
    /// 토큰 배열을 리턴
    func fetchTokens() -> [TOTPToken] {
        return [
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "1번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "2번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "3번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "4번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "5번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "6번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "7번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "8번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "9번토큰", color: "#123123", icon: "Zzzzz"),
            TOTPToken(key: "6UAOpz+x3dsNrQ==", tokenName: "10번토큰", color: "#123123", icon: "Zzzzz")
        ]
    }
    
}

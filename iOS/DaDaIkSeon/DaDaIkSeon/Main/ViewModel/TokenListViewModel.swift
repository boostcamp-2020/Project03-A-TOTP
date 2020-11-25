//
//  MainViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation

final class TokenListViewModel: ObservableObject {
    @Published var tokens: [TokenViewModel] = []
    
    init() {
        fetchTokens()
    }
    
    /// 토큰 배열을 리턴
    func fetchTokens() {
        tokens = [TokenViewModel.init(token: Token(id: UUID(), key: "333 333", tokenName: "token1", color: nil, icon: nil)),
                  TokenViewModel.init(token: Token(id: UUID(), key: "111 111", tokenName: "token2", color: nil, icon: nil)),
                  TokenViewModel.init(token: Token(id: UUID(), key: "222 222", tokenName: "token3", color: nil, icon: nil)),
                  TokenViewModel.init(token: Token(id: UUID(), key: "555 555", tokenName: "token4", color: nil, icon: nil)),
                  TokenViewModel.init(token: Token(id: UUID(), key: "123 123", tokenName: "token5", color: nil, icon: nil)),
                  TokenViewModel.init(token: Token(id: UUID(), key: "234 234", tokenName: "token6", color: nil, icon: nil))]
    }
    
}

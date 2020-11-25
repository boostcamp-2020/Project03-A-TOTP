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
        tokens = [TokenViewModel(token:
                                    Token(id: UUID(), key: "hizhizhi", tokenName: "byebye", color: nil, icon: nil)),
                  TokenViewModel(token:
                                    Token(id: UUID(), key: "s", tokenName: "byebye", color: nil, icon: nil)),
                  TokenViewModel(token:
                                    Token(id: UUID(), key: "hizhizdfhi", tokenName: "byebye", color: nil, icon: nil)),
                  TokenViewModel(token:
                                    Token(id: UUID(), key: "hizhifzhi", tokenName: "byebye", color: nil, icon: nil)),
                  TokenViewModel(token:
                                    Token(id: UUID(), key: "hizhidgzhi", tokenName: "byebye", color: nil, icon: nil)),
                  TokenViewModel(token:
                                    Token(id: UUID(), key: "hizhidszhi", tokenName: "byebye", color: nil, icon: nil))]
    }
    
}

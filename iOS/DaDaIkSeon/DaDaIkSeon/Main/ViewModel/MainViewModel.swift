//
//  MainViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    // MARK: Property
    
    @Published var filteredTokens: [TokenViewModel] = []
    @Published var searchText = ""
    @Published var isSearching = false
    @Published var mainCell
        = Token(id: UUID(),
                key: "6UAOpz+x3dsNrQ==",
                tokenName: "토큰의이름은두줄두줄두줄두줄두줄두줄두줄두줄두줄",
                color: nil, icon: nil)
    
    var publisher: AnyCancellable?
    var tokens: [TokenViewModel] = []
    
    // MARK: Init
    
    init() {
        fetchTokens()
        
        publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] input in
                guard let weakSelf = self else { return }
                weakSelf.searchTextChanged(text: input)
            })
    }
    
    // MARK: Actions
    
    func searchTextChanged(text: String) {
        filteredTokens = tokens.filter {
            $0.token.tokenName?.contains(searchText) ?? false || searchText.isEmpty
        }
    }
    
    /// 토큰 배열을 리턴
    func fetchTokens() {
        tokens = [
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "111 111",
                             tokenName: "token1",
                             color: nil,
                             icon: nil)
            ),
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "222 222",
                             tokenName: "token2",
                             color: nil,
                             icon: nil)
            ),
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "333 333",
                             tokenName: "token3",
                             color: nil,
                             icon: nil)
            ),
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "444 444",
                             tokenName: "token4",
                             color: nil,
                             icon: nil)
            ),
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "555 555",
                             tokenName: "token5",
                             color: nil,
                             icon: nil)
            )]
    }
    
}

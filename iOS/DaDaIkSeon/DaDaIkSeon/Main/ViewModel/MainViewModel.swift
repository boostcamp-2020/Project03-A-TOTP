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
                tokenName: "토큰의 이름은 두 줄 까지만 가능합니다.",
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
                             key: "WEJ3NLTTYHF4XVXG",
                             tokenName: "배고파",
                             color: "pink",
                             icon: nil)
            ),
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "nv66p42pcv4f2fbgetakq6clottovx7z",
                             tokenName: "네이버2",
                             color: "salmon",
                             icon: nil)
            ),
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "WEJ3NLTTYHF4XVXG",
                             tokenName: "네이버",
                             color: "navy",
                             icon: nil)
            ),
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "6UAOpz+x3dsNrQ==",
                             tokenName: "구글",
                             color: "blue",
                             icon: nil)
            ),
            TokenViewModel(
                token: Token(id: UUID(),
                             key: "nv66p42pcv4f2fbgetakq6clottovx7z",
                             tokenName: "배아파",
                             color: "brown",
                             icon: nil)
            )]
    }
    
}

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
        tokens = Token.dummy().map {
            TokenViewModel(token: $0)
        }
    }
    
}

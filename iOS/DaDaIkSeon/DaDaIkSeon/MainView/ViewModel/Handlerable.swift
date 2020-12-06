//
//  Handlerable.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/06.
//

import Foundation

protocol Handlerable {
    func trigger()
}

class SearchHandler: Handlerable {
    
    private let searchInput: SearchInput
    @Published var state: MainState
    
    init(_ searchInput: SearchInput, _ state: Published<MainState>) {
        self.searchInput = searchInput
        self._state = state
    }
    
    func trigger() {
        switch searchInput {
        case .search(let text):
            search(text)
        case .startSearch:
            startSearch()
        case .endSearch:
            endSearch()
            showMainScene()
        }
    }
    
    func search(_ text: String) {
        state.filteredTokens = state.service.tokenList().filter {
            $0.tokenName?.contains(text) ?? false || text.isEmpty
        }
    }
    
    func endSearch() {
        state.isSearching = false
    }
    
    func startSearch() {
        state.isSearching = true
        state.filteredTokens = state.service.tokenList()
    }
    
    func showMainScene() {
        if state.service.tokenCount == 0 {
            state.zeroTokenState = true
            state.filteredTokens = []
        } else {
            if state.service.tokenCount == 1 {
                state.zeroTokenState = false
            }
            if let maintoken = state.service.mainToken() {
                state.mainToken = maintoken
                state.filteredTokens = excludeMainCell()
                return
            }
        }
    }
    
    func excludeMainCell() -> [Token] {
        state.service.excludeMainCell()
    }
}

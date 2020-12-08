//
//  SearchHandler.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

final class SearchHandler: CommonHandler {
    
    private let input: SearchInput
    
    init(_ searchInput: SearchInput, _ state: Published<MainState>) {
        self.input = searchInput
        super.init(state)
    }
    
    override func trigger() {
        switch input {
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
            $0.name?.contains(text) ?? false || text.isEmpty
        }
    }
    
    func startSearch() {
        state.isSearching = true
        state.filteredTokens = state.service.tokenList()
    }
    
}

//
//  MainViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation

final class MainViewModel: ViewModel {
    
    // MARK: Property
    
    @Published var state: MainState
    
    init(service: TokenServiceable) {
        let tokens = service.loadTokens()
        let isSearching = service.getSearchingState()
        let searchText = service.getSearchText()
        
        state = MainState(service: service,
                          filteredTokens: tokens,
                          searchText: searchText,
                          isSearching: isSearching)
    }
    
    // MARK: Methods
    
    func trigger(_ input: MainInput) {
        switch input {
        case .startSearch(let text):
            state.searchText = text
            state.isSearching = true
            state.filteredTokens = state.service.getFilteredTokens(text: text)
        case .endSearch:
            state.searchText = ""
            state.isSearching = false
        }
    }
    
}

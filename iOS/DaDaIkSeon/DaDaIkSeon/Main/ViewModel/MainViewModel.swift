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
        state = MainState(service: service,
                          filteredTokens: [],
                          searchText: "",
                          isSearching: false,
                          mainToken: service.mainToken())
        state.filteredTokens = excludeMainCell()
    }
    
    // MARK: Methods
    
    func trigger(_ input: MainInput) {
        switch input {
        case .startSearch(let text):
            state.searchText = text
            state.isSearching = true
            state.filteredTokens = state.service.tokenList().filter {
                $0.tokenName?.contains(text) ?? false || text.isEmpty
            }
        case .endSearch:
            endSearch()
            showMainScene()
        case .moveToken(let id):
            state.service.updateMainTokenIndex(id: id)
            if state.isSearching {
                endSearch()
                showMainScene()
                return
            }
            showMainScene()
        case .refreshTokens:
            showMainScene()
        }
    }

}

extension MainViewModel {
    
    func endSearch() {
        state.searchText = ""
        state.isSearching = false
    }
    
    func showMainScene() {
        state.mainToken = state.service.mainToken()
        state.filteredTokens = excludeMainCell()
    }
    
    func excludeMainCell() -> [Token] {
        state.service.tokenList().filter {
            $0.id != state.service.mainToken().id
        }
    }
    
}

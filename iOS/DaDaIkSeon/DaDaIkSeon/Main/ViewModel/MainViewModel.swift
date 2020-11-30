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
            state.searchText = ""
            state.isSearching = false
        case .moveToken(let id):
            state.service.updateMainTokenIndex(id: id)
            state.mainToken = state.service.token(id: id) ?? Token()
            state.filteredTokens = excludeMainCell()
        }
    }

}

extension MainViewModel {
    func excludeMainCell() -> [Token] {
        state.service.tokenList().filter {
            $0.id != state.service.mainToken().id
        }
    }
}

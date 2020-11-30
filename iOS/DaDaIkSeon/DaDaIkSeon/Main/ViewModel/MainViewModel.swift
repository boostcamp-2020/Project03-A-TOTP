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
        let filteredTokens = service.excludeMainCell()
        let isSearching = service.getSearchingState()
        let searchText = service.getSearchText()
        let mainToken = service.getMainToken()
        
        state = MainState(service: service,
                          filteredTokens: filteredTokens,
                          searchText: searchText,
                          isSearching: isSearching,
                          mainToken: mainToken)
    }
    
    // MARK: Methods
    
    func trigger(_ input: MainInput) {
        switch input {
        case .startSearch(let text):
            state.searchText = text
            state.isSearching = true
            state.filteredTokens = state.service.getFilteredTokens(text: text)
            //state.service.tokens.filter
            
        case .endSearch:
            state.searchText = ""
            state.isSearching = false
        case .moveToken(let id):
            //state.mainToken = state.service.moveToken(id: id)
            
            let lastMainToken = state.service.getMainToken()
            state.service.setMainTokenIndex(id: id)
            state.mainToken = state.service.token(id: id) ?? Token()
//            state.filteredTokens.removeAll(where: { $0.id == id })
//            state.filteredTokens.append(lastMainToken)
            state.filteredTokens = state.service.excludeMainCell()
        // 처음에 메인뷰에 있던 뷰가 append로 추가되어도 안보이는 이유 -> 기존에 날라갔던 게 아니기 때문. 재사용할 원본이 없어서?
            
        }
    }
    
}

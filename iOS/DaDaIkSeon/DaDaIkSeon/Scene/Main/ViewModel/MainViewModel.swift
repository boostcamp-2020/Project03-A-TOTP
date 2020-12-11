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
                          filteredTokens: service.excludeMainCell(),
                          isSearching: false,
                          mainToken: Token(),
                          checkBoxMode: false,
                          selectedTokens: [UUID: Bool](),
                          selectedCount: 0,
                          zeroTokenState: service.tokenCount == 0
        )
    }
    
    // MARK: Methods
    
    func trigger(_ input: MainInput) {
        switch input {
        case .commonInput(let commonInput):
            CommonHandler(commonInput, _state).trigger()
        case .searchInput(let searchInput):
            SearchHandler(searchInput, _state).trigger()
        case .checkBoxInput(let checkBoxInput):
            CheckBoxHandler(checkBoxInput, _state).trigger()
        case .cellInput(let cellInput):
            CellHandler(cellInput, _state).trigger()
        }
    }
}

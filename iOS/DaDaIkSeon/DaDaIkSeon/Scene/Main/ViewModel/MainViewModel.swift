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
                          isSearching: false,
                          mainToken: Token(),
                          checkBoxMode: false,
                          selectedTokens: [String: Bool](),
                          selectedCount: 0,
                          zeroTokenState: true,
                          hasBackupPassword: false
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

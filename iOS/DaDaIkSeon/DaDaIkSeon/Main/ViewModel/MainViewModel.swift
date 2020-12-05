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
                          mainToken: Token(),
                          checkBoxMode: false,
                          selectedTokens: [UUID: Bool](),
                          settingMode: false,
                          selectedCount: 0,
                          zeroTokenState: service.tokenCount == 0
        )
        showMainScene()
    }
    
    // MARK: Methods
    
    func trigger(_ input: MainInput) {
        switch input {
        case .search(let text):
            state.searchText = text
            state.isSearching = true
            state.filteredTokens = state.service.tokenList().filter {
                $0.tokenName?.contains(text) ?? false || text.isEmpty
            }
        case .startSearch:
            startSearch()
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
        case .showCheckBox:
            state.checkBoxMode = true
            state.service.tokenList().forEach {
                state.selectedTokens[$0.id] = false
            }
        case .hideCheckBox:
            state.checkBoxMode = false
            state.selectedTokens.removeAll()
            state.selectedCount = 0
        case .selectCell(let id):
            if let token = state.selectedTokens[id] {
                if token {
                    state.selectedCount -= 1
                    state.selectedTokens[id] = false
                } else {
                    state.selectedCount += 1
                    state.selectedTokens[id] = true
                }
            }
        case .deleteSelectedTokens:
            state.service.removeTokens(
                state.selectedTokens
                    .filter { $0.value == true}
                    .map { $0.key })
            trigger(.hideCheckBox)
            state.selectedCount = 0
            showMainScene()
        case .startSetting:
            state.settingMode = true
        case .endSetting:
            state.settingMode = false
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
    
    func startSearch() {
        state.isSearching = true
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
                state.filteredTokens = excludeMainCell(mainId: maintoken.id)
                return
            }
        }
    }
    
    func excludeMainCell(mainId: UUID) -> [Token] {
        state.service.tokenList().filter {
            $0.id != mainId
        }
    }
    
}

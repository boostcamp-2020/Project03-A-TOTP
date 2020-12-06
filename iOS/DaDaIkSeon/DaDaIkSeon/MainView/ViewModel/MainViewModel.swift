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
        case .searchInput(let searchInput):
            SearchHandler(searchInput, _state).trigger()
        case .checkBoxInput(let checkBoxInput):
            CheckBoxHandler(checkBoxInput, _state).trigger()
        case .cellInput(let cellInput):
            handleCellInput(cellInput)
            
        case .settingInput(let settingInput):
            handleSettingInput(settingInput)
            
        case .refreshTokens:
            showMainScene()
        }
    }
    
    func handleCellInput(_ input: CellInput) {
        switch input {
        case .selectCell(let id):
            selectCell(id)
        case .startDragging(let token):
            startDragging(token: token)
        case .endDragging:
            endDragging()
        case .moveToMain(let id):
            moveToMain(id)
            showMainScene()
        case .move(let from, let target):
            move(from: from, target: target)
            showMainScene()
        }
    }
    
    func handleSettingInput(_ settingInput: SettingInput) {
        switch settingInput {
        case .startSetting:
            startSetting()
        case .endSetting:
            endSetting()
        }
    }
}

private extension MainViewModel {
    
    // MARK: Common
    
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
    
    func endSearch() {
        state.isSearching = false
    }
    
    // MARK: CheckBox
    
//    func showCheckBox() {
//        state.checkBoxMode = true
//        state.service.tokenList().forEach {
//            state.selectedTokens[$0.id] = false
//        }
//    }
//
//    func hideCheckBox() {
//        state.checkBoxMode = false
//        state.selectedTokens.removeAll()
//        state.selectedCount = 0
//    }
//
//    func deleteSelectedTokens() {
//        let deletedTokens = state.selectedTokens
//            .filter { $0.value == true}
//            .map { $0.key }
//        TOTPTimer.shared.deleteSubscribers(tokenIDs: deletedTokens)
//        state.service.removeTokens(deletedTokens)
//    }
    
    // MARK: Cell
    
    func selectCell(_ id: UUID) {
        if let token = state.selectedTokens[id] {
            if token {
                state.selectedCount -= 1
                state.selectedTokens[id] = false
            } else {
                state.selectedCount += 1
                state.selectedTokens[id] = true
            }
        }
    }
    
    
    func moveToMain(_ id: UUID) {
        state.service.updateMainToken(id: id)
        if state.isSearching {
            endSearch()
            showMainScene()
            return
        }
    }
    
    
    
    func startDragging(token: Token) {
        state.tokenOnDrag = token
    }
    
    func endDragging() {
        state.tokenOnDrag = nil
    }
    
    func move(from: Int, target: Int) {
        state.service.updateTokenPosition(from: from, target: target)
    }
    
    // MARK: Setting
    
    func startSetting() {
        state.settingMode = true
    }
    
    func endSetting() {
        state.settingMode = false
    }
    
}

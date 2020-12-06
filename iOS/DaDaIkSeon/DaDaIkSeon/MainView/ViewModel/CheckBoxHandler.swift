//
//  CheckBoxHandler.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

class CheckBoxHandler: CommonHandler {
    
    private let input: CheckBoxInput
    
    init(_ searchInput: CheckBoxInput, _ state: Published<MainState>) {
        self.input = searchInput
        super.init(state)
    }
    
    override func trigger() {
        switch input {
        case .showCheckBox:
            showCheckBox()
        case .hideCheckBox:
            hideCheckBox()
        case .selectCell(let id):
            selectCell(id)
        case .deleteSelectedTokens:
            deleteSelectedTokens()
            hideCheckBox()
            showMainScene()
        }
    }
    
    func showCheckBox() {
        state.checkBoxMode = true
        state.service.tokenList().forEach {
            state.selectedTokens[$0.id] = false
        }
    }
    
    func hideCheckBox() {
        state.checkBoxMode = false
        state.selectedTokens.removeAll()
        state.selectedCount = 0
    }
    
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
    
    func deleteSelectedTokens() {
        let deletedTokens = state.selectedTokens
            .filter { $0.value == true}
            .map { $0.key }
        TOTPTimer.shared.deleteSubscribers(tokenIDs: deletedTokens)
        state.service.removeTokens(deletedTokens)
    }
}

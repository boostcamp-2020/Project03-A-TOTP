//
//  Handlerable.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/06.
//

import Foundation

protocol Handlerable {
    func trigger()
}

class MainHandler: Handlerable {
    @Published var state: MainState
    
    init(_ state: Published<MainState>) {
        self._state = state
    }
    
    func trigger() { }
    
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
    
}

class CheckBoxHandler: MainHandler {
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
    
    func deleteSelectedTokens() {
        let deletedTokens = state.selectedTokens
            .filter { $0.value == true}
            .map { $0.key }
        TOTPTimer.shared.deleteSubscribers(tokenIDs: deletedTokens)
        state.service.removeTokens(deletedTokens)
    }
}

class SearchHandler: MainHandler {
    
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
            $0.tokenName?.contains(text) ?? false || text.isEmpty
        }
    }
    
    func startSearch() {
        state.isSearching = true
        state.filteredTokens = state.service.tokenList()
    }
    
}

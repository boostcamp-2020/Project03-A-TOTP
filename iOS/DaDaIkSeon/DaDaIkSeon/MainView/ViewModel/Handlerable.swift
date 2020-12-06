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
    
    func trigger() {
        showMainScene()
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

class CellHandler: MainHandler {
    private let input: CellInput
    
    init(_ searchInput: CellInput, _ state: Published<MainState>) {
        self.input = searchInput
        super.init(state)
    }
    
    override func trigger() {
        switch input {
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
    
}

//
//  CellHandler.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

class CellHandler: CommonHandler {
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

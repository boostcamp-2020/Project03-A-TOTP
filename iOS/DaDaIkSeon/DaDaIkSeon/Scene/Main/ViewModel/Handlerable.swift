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

class CommonHandler: Handlerable {
    
    private var input: CommonInput?
    @Published var state: MainState
    
    init(_ input: CommonInput? = nil, _ state: Published<MainState>) {
        self.input = input
        self._state = state
    }
    
    init(_ state: Published<MainState>) {
        self._state = state
    }
    
    func trigger() {
        guard let input = input else { return }
        switch input {
        case .refreshTokens:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.showMainScene()
            }
        }
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

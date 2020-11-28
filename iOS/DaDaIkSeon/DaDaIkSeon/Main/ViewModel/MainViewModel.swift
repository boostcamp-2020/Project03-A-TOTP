//
//  MainViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation
import Combine

final class MainViewModel: ViewModel {
    
    // MARK: Property
    
    @Published var state: MainState
    
    init(service: MainServiceable) {
        let tokens = service.loadTokens()
        state = MainState(service: service, filteredTokens: tokens)
    }
    
    // MARK: Methods
    
    func trigger(_ input: MainInput) {
        switch input {
        case .search(let text):
            state.filteredTokens = state.service.getFilteredTokens(text: text)
        }
    }
    
}

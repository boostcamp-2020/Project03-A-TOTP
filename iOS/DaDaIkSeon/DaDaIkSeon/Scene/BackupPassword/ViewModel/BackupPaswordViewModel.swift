//
//  BackupPaswordViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/15.
//

import Foundation

class BackupPasswordViewModel: ViewModel {
    
    @Published var state: BackupPasswordState
    
    init(service: TokenServiceable) {
        state = BackupPasswordState(service: service)
    }
    
    func trigger(_ input: BackupPasswordInput) {
        
        switch input {
        case .inputPassword(let input):
            if input.checkStyle(type: .password) {
                state.errorMessage = .none
            } else {
                state.errorMessage = .inputFormat
            }
        case .inputPasswordCheck(let last, let current):
            if current.count > 0 {
                if last == current {
                    state.enable = true
                    state.errorMessage = .none
                } else {
                    state.enable = false
                    state.errorMessage = .isNotSame
                }
            } else {
                state.errorMessage = .none
            }
        case .next:
            state.next = true
            print("next!!! \(state.service.loadTokens())")
        }
    }
    
}

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
        
        // 비밀번호 설정 뷰가 떴을 때 바로 GET요청을 한다.
        // 이때, 데이터가 있으면, 패스워드뷰를 1개만 띄우고, 없으면 2개를 띄운다.
        refreshTokens()
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
            refreshTokens()
        }
    }
    
}

extension BackupPasswordViewModel {
    
    func refreshTokens() {
        state.service.refreshTokens(updateView: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .successLoad:
                print("메인화면으로 이동해야함")
                self.state.isMultiUser = false
            case .failedDecryption:
//            case .failedDecryption(let data):
                print("비밀번호 틀림, 다시호출")
                // service.decryptKey??? fh ektl qnfmsek.....
                self.state.isMultiUser = false
            default:
                print("비밀번호 두개 다 입력하고 아무것도 안 뜸")
                self.state.isMultiUser = true
                return
            }
        })
    }
    
}

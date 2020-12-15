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
            if input.count > 5 && state.isMultiUser {
                state.enable = true
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
        case .next(let password):
            state.backupPassword = password
            refreshTokens(isInit: false)
        }
    }
    
}

extension BackupPasswordViewModel {
    
    func refreshTokens(isInit: Bool = true) {
        state.service.refreshTokens(updateView: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .successLoad:
                    print("메인화면으로 이동해야함")
                    self.state.isMultiUser = false
                    if !isInit {
                        self.state.next = true
                    }
                case .failedDecryption(let tokens):
                    print("비밀번호 틀림, 다시호출 \(tokens)")
                    self.state.isMultiUser = true
                    if !isInit {
                        self.state.next = self.decryptTokenKeys(tokens)
                    }
                case .noTokens:
                    print("토큰이 아무것도 없는 경우")
                    if !isInit {
                        self.setBackupPassword()
                        self.state.next = true
                    }
                case .noBackupPassword:
                    print("백업 패스워드가 없어서 설정해야함.")
                    self.state.isMultiUser = false
                    if !isInit {
                        self.setBackupPassword()
                        self.state.next = true
                    }
                default:
                    print("비밀번호 두개 다 입력하고 아무것도 안 뜸")
                    self.state.isMultiUser = false
                    self.state.next = false
                    return
                }
            }
        })
    }
    
    func decryptTokenKeys(_ tokens: [Token]) -> Bool {
        let result = state.service.decryptTokenKeys(tokens: tokens,
                                                    password: state.backupPassword)
        
        switch result {
        case .successLoad:
            return true
        default:
            return false
        }
    }
    
    func setBackupPassword() {
        BackupPasswordManager().storePassword(state.backupPassword)
    }
    
}

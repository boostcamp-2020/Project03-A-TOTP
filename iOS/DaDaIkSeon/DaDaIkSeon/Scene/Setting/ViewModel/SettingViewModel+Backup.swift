//
//  SettingViewModel+Backup.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import Foundation

// MARK: Backup
extension SettingViewModel {
    func handlerForBackupSetting(_ input: SettingBackup) {
        switch input {
        case .backupToggle:
            if state.backupToggle {
                updateBackupMode(false)
            } else {
                // 백업 비밀번호가 내장되어 있으면 바로 true 요청.
                if nil != state.service.readBackupPassword() {
                    updateBackupMode(true)
                } else {
                    trigger(.settingBackup(.editBackupPasswordMode))
                }
            }
        case .editBackupPasswordMode:
            state.backupPasswordEditMode.toggle()
            state.backupPasswordEditCheckMode = false
            state.passwordErrorMessage = .none
        case .editBackupPassword(let password):
            if password.checkStyle(type: .password) {
                state.service.updateBackupPassword(password)
                state.backupPasswordEditMode = false
                state.backupPasswordEditCheckMode = true
                state.passwordErrorMessage = .none
            } else {
                state.backupPasswordEditCheckMode = false
                state.passwordErrorMessage = .string
            }
        case .checkPassword(let last, let check):
            if last == check {
                state.service.updateBackupPassword(last)
                state.backupPasswordEditCheckMode = false
                state.passwordErrorMessage = .none
                // 토큰 update해줘야 함.
                if backupToggleGoingToOn() {
                    updateBackupMode(true)
                }
            } else {
                state.passwordErrorMessage = .different
            }
        }
    }
    
    func updateBackupMode(_ mode: Bool) {
        state.service.updateBackupMode(currentUDID, backup: mode) { result in
            switch result {
            case .result:
                DispatchQueue.main.async {
                    self.state.backupToggle = mode
                }
            case .dataParsingError:
                break
            case .messageError:
                break
            case .networkError:
                break
            }
        }
    }
    
    func backupToggleGoingToOn() -> Bool {
        state.backupToggle == false
    }
    
}

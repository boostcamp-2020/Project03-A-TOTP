//
//  SettingViewModel+SettingEmail.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import Foundation

// MARK: Email
extension SettingViewModel {
    
    func handlerForEemailSetting(_ input: SettingEmail) {
        switch input {
        case .editEmail(let email):
            if email.checkStyle(type: .email) {
                state.service.updateEmail(email) { result in
                    switch result {
                    case .emailEdit:
                        DispatchQueue.main.async {
                            self.state.email = email
                        }
                    default: break
                    }
                }
                state.email = state.service.readEmail() ?? ""
                state.emailEditMode = false
                state.emailValidation = true
            } else {
                state.emailValidation = false
            }
        case .editEmailMode:
            state.emailEditMode.toggle()
            state.emailValidation = true
        }
    }
}

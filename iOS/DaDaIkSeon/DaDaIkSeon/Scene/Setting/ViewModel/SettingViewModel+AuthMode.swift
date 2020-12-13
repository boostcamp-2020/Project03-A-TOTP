//
//  SettingViewModel+SettingAuthMode.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import Foundation

extension SettingViewModel {
    func handlerForAuthModeSetting(_ input: SettingEditAuth) {
        switch input {
        case .editAuthMode:
            state.authEditMode.toggle()
        case .protectDaDaIkSeon(let pincode):
            state.service.createPincde(pincode) // 네트워크랑 상관 무
        case .liberateDaDaIkSeon:
            state.service.deletePincode()
        }
    }
}

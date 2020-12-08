//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

class SettingViewModel: ViewModel {
    
    @Published var state: SettingState
    
    init() {
        let service = MockSettingService()
        let email = service.readEmail() ?? ""
        let devices = service.readDevice() ?? Device.dummy()
        state = SettingState(
            service: service,
            email: email,
            devices: devices
        )
    }
  
    func trigger(_ input: SettingInput) {
        switch input {
        case .backupToggle:
            state.service.updateBackupMode()
        case .multiDeviceToggle:
            state.service.updateMultiDeviceMode()
        case .refresh:
            state.service.refresh()
        }
    }
    
}

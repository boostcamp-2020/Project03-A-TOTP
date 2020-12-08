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
            print("백업할래")
        case .multiDeviceToggle:
            state.service.updateMultiDeviceMode()
            print("기기 여러개 쓸래")
        case .refresh:
            state.service.refresh()
            print("백업할래")
        }
    }
    
}

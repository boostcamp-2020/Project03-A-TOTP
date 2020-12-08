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
        
        case .refresh:
            state.service.refresh()
            print("refresh")
            
        case .editEmail(let email):
            state.service.updateEmail(email)
            print("email")
            
        case .backupToggle:
            state.service.updateBackupMode()
            print("backupToggle")
        case .editBackupPassword(let password):
            state.service.updateBackupPassword(password)
        
        case .multiDeviceToggle:
            state.service.updateMultiDeviceMode()
            print("multiDeviceToggle")
            
        case .editDevice(let device):
            state.service.updateDevice(device)
            print("editDevice")
            
        case .deleteDevice(let deviceID):
            state.service.deleteDevice(deviceID)
            print("deleteDevice")
        }
    }
    
}

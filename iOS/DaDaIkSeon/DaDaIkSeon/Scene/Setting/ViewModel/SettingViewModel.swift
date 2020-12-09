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
            emailEditMode: false,
            emailValidation: true,
            devices: devices
        )
    }
  
    func trigger(_ input: SettingInput) {
        switch input {
        
        case .refresh:
            state.service.refresh()
            print("refresh")
        case .editEmailMode:
            state.emailEditMode.toggle()
        case .editEmail(let email):
            if email.count > 5 && email.contains("@") {
                // 참
                state.service.updateEmail(email)
                state.email = state.service.readEmail() ?? ""
                state.emailEditMode = false
                state.emailValidation = true
            } else {
                state.emailValidation = false
            }
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

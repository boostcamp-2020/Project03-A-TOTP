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
            backupPasswordEditMode: false,
            backupPasswordEditCheckMode: false,
            backupPasswordErrorMessage: .none,
            deviceID: "",
            deviceInfoMode: false,
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
            state.emailValidation = true
        case .editEmail(let email):
            if email.count > 5 && email.contains("@") {
                state.service.updateEmail(email)
                state.email = state.service.readEmail() ?? ""
                state.emailEditMode = false
                state.emailValidation = true
            } else {
                state.emailValidation = false
            }
        case .backupToggle:
            state.service.updateBackupMode()
            
        case .editBackupPasswordMode:
            state.backupPasswordEditMode.toggle()
            state.backupPasswordEditCheckMode = false
            state.backupPasswordErrorMessage = .none
        case .editBackupPassword(let password):
            if password.count > 5 {
                state.service.updateBackupPassword(password)
                state.backupPasswordEditMode = false
                state.backupPasswordEditCheckMode = true
                state.backupPasswordErrorMessage = .none
            } else {
                state.backupPasswordEditCheckMode = false
                state.backupPasswordErrorMessage = .stringSize
            }
        case .checkPassword(let last, let check):
            if last == check {
                state.service.updateBackupPassword(last)
                state.backupPasswordEditCheckMode = false
                state.backupPasswordErrorMessage = .none
            } else {
                state.backupPasswordErrorMessage = .different
            }
        case .multiDeviceToggle:
            state.service.updateMultiDeviceMode()
            print("multiDeviceToggle")
            
        case .editDevice(let device):
            state.service.updateDevice(device)
            print("editDevice")
            
        case .deleteDevice(let deviceID):
            state.service.deleteDevice(deviceID)
            print("deleteDevice")
        
        case .deviceInfoMode(let udid):
            state.deviceInfoMode.toggle()
            if state.deviceInfoMode {
                state.deviceID = udid
            } else {
                state.deviceID = ""
            }
        }
    }
    
}

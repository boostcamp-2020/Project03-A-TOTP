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
            authEditMode: false,
            backupToggle: false,
            backupPasswordEditMode: false,
            backupPasswordEditCheckMode: false,
            editErrorMessage: .none,
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
            //state.service.updateBackupMode()
            if state.backupToggle {
                // off 로 가기 - 끄기
                
            } else {
                // on으로 가기 - 켜기
                
            }
        case .editBackupPasswordMode:
            state.backupPasswordEditMode.toggle()
            state.backupPasswordEditCheckMode = false
            state.editErrorMessage = .none
        case .editBackupPassword(let password):
            if password.count > 5 {
                state.service.updateBackupPassword(password)
                state.backupPasswordEditMode = false
                state.backupPasswordEditCheckMode = true
                state.editErrorMessage = .none
            } else {
                state.backupPasswordEditCheckMode = false
                state.editErrorMessage = .stringSize
            }
        case .checkPassword(let last, let check):
            if last == check {
                state.service.updateBackupPassword(last)
                state.backupPasswordEditCheckMode = false
                state.editErrorMessage = .none
            } else {
                state.editErrorMessage = .different
            }
        case .multiDeviceToggle:
            state.service.updateMultiDeviceMode()
            print("multiDeviceToggle")
            
        case .editDevice(let device):
            guard let name = device.name else { return }
            if name.count > 3 {
                state.deviceInfoMode = false
                state.deviceID = ""
                state.editErrorMessage = .none
                state.service.updateDevice(device)
                state.devices = state.service.readDevice() ?? Device.dummy()
            } else {
                state.editErrorMessage = .stringSize
            }
        case .deleteDevice(let deviceID): break
            // alert 띄워서 확인 후 삭제
            //state.service.deleteDevice(deviceID)
        case .deviceInfoMode(let udid):
            state.deviceInfoMode.toggle()
            state.editErrorMessage = .none
            if state.deviceInfoMode {
                state.deviceID = udid
            } else {
                state.deviceID = ""
            }
        case .editAuthMode:
            state.authEditMode.toggle()
        case .protectDaDaIkSeon(let pincode):
            state.service.createPincde(pincode)
            print("protectTokens \(pincode)")
        case .liberateDaDaIkSeon:
            state.service.deletePincode()
            print("liberateDaDaIkSeon")
        }
    }
}

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
            deviceToggle: false,
            deviceID: "",
            deviceInfoMode: false,
            devices: devices
        )
    }
  
    func trigger(_ input: SettingInput) {
        switch input {
        case .refresh: // onAppear에서 호출
            state.service.refresh()
        // MARK: Email
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
            
        // MARK: Backup
        case .backupToggle:
            //state.service.updateBackupMode()
            if state.backupToggle {
                state.backupToggle = false
            } else {
                // 백업 비밀번호가 내장되어 있으면 바로 true 요청.
                if nil != state.service.readBackupPassword() {
                    state.backupToggle = true
                } else { // 없으면 새로 생성후 로컬에 저장한 다음에 네트워크 요청
                    // alert로 비밀번호를 설정해야한다고 알려야 한다.
                    trigger(.editBackupPasswordMode)
                }
            }
        case .editBackupPasswordMode:
            state.backupPasswordEditMode.toggle()
            state.backupPasswordEditCheckMode = false
            state.editErrorMessage = .none
        case .editBackupPassword(let password):
            if check(password: password) {
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
                if backupToggleGoingToOn() {
                    state.backupToggle = true
                }
            } else {
                state.editErrorMessage = .different
            }
            
        // MARK: MultiDevice
        case .multiDeviceToggle:
            if state.deviceToggle {
                state.service.updateMultiDeviceMode(false) {
                    DispatchQueue.main.async {
                        self.state.deviceToggle = false
                    }
                }
            } else {
                state.service.updateMultiDeviceMode(true) {
                    DispatchQueue.main.async {
                        self.state.deviceToggle = true
                    }
                }
            }
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
        case .deleteDevice(let deviceID, let myDeviceID):
            if deviceID != myDeviceID {
                // alert 띄워서 확인 후 삭제해주기
                state.service.deleteDevice(deviceID)
            } else {
                
            }
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
            state.service.createPincde(pincode) // 네트워크랑 상관 무
        case .liberateDaDaIkSeon:
            state.service.deletePincode()
        }
    }
}

extension SettingViewModel {
    func check(password: String) -> Bool {
        password.count > 5
    }
    
    func backupToggleGoingToOn() -> Bool {
        state.backupToggle == false
    }
}

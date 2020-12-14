//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

class SettingViewModel: ViewModel {
    
    @Published var state: SettingState
    let currentUDID: String
    
    init(udid: String) {
        currentUDID = udid
        let service = MockSettingService()
        let email = service.readEmail() ?? ""
        var devices = service.readDevice() ?? Device.dummy()
        let index = devices.firstIndex(where: { $0.udid == udid })
        devices.move(fromOffsets: IndexSet(integer: index ?? 0), toOffset: 0)
        state = SettingState(
            service: service,
            email: email,
            emailEditMode: false,
            emailValidation: true,
            authEditMode: false,
            backupToggle: false,
            backupPasswordEditMode: false,
            backupPasswordEditCheckMode: false,
            passwordErrorMessage: .none,
            deviceToggle: false,
            selectedDeviceID: "",
            deviceInfoMode: false,
            deviceErrorMessage: .none,
            devices: devices
        )
    }
    
    func trigger(_ input: SettingInput) {
        switch input {
        // error: 설정 정보를 불러오는 데 실패하였습니다. 네트워크 연결을 확인해주세요.
        case .refresh: // onAppear에서 호출
            state.service.refresh { result in
                switch result {
                case .refresh(let user):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        if let email = user.email {
                            self.state.email = email
                        }
                        if let devices = user.devices {
                            self.state.devices = devices
                            if let myDevice = devices.first(where: {
                                $0.udid == self.currentUDID
                            }) {
                                if let backup = myDevice.backup {
                                    self.state.backupToggle = backup
                                }
                            }
                        }
                        
                        if let multiDevice = user.multiDevice {
                            self.state.deviceToggle = multiDevice
                        }
                    }
                default:
                    break
                }
            }
        case .settingAuthMode(let input):
            handlerForAuthModeSetting(input)
            
        // MARK: Email
        case .settingEmail(let input):
            handlerForEemailSetting(input)
            
        // MARK: Backup
        case .settingBackup(let input):
            handlerForBackupSetting(input)
            
        // MARK: MultiDevice
        case .settingMultiDevice(let input):
            handlerForMultiDeviceSetting(input)
        }
    }
}

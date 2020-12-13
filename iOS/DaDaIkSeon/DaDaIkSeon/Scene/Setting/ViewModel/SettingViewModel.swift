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

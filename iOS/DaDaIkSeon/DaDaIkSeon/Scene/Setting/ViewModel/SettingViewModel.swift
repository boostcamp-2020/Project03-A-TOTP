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
    
    func myDeviceToFirst() {
        
    }
    
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
        case .refresh: // onAppear에서 호출
            //state.service.refresh()
        break
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

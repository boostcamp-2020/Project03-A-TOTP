//
//  SettingViewModel+MultiDevice.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import Foundation

extension SettingViewModel {
    func handlerForMultiDeviceSetting(_ input: SettingMultiDevice) {
        switch input {
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
        case .deleteDevice(let deviceID):
            if deviceID != currentUDID {
                // alert 띄워서 확인 후 삭제해주기
                state.service.deleteDevice(deviceID)
            } else {
                // alert 자기꺼는 삭제 못함 알려주기
            }
        case .deviceInfoMode(let udid):
            state.deviceInfoMode.toggle()
            state.editErrorMessage = .none
            if state.deviceInfoMode {
                state.deviceID = udid
            } else {
                state.deviceID = ""
            }
        }
    }
}

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
            state.service.updateMultiDeviceMode(!state.deviceToggle) { result in
                switch result {
                case .result(let data):
                    print("data")
                    DispatchQueue.main.async {
                        self.state.deviceToggle.toggle()
                    }
                case .dataParsingError:
                    print("dataParsingError 실패")
                case .messageError:
                    print("messageError 실패")
                case .networkError:
                    print("networkError 실패")
                }
            }
        case .editDevice(let device):
            state.selectedDeviceID = ""
            state.editErrorMessage = .none
            state.service.updateDevice(device)
            state.devices = state.service.readDevice() ?? Device.dummy()
        case .deleteDevice(let deviceID):
            if deviceID != currentUDID {
                // alert 띄워서 확인 후 삭제해주기
                state.service.deleteDevice(deviceID)
            } else {
                // alert 자기꺼는 삭제 못함 알려주기
            }
        case .deviceInfoMode(let udid):
            if state.selectedDeviceID == udid {
                state.selectedDeviceID = ""
            } else {
                state.selectedDeviceID = udid
            }
        }
    }
}

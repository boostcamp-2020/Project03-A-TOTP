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
                case .multiDeviceToggle:
                    DispatchQueue.main.async {
                        self.state.deviceToggle.toggle()
                    }
                case .dataParsingError:
                    print("dataParsingError 실패")
                case .messageError:
                    print("messageError 실패")
                case .networkError:
                    print("networkError 실패")
                default: break
                }
            }
        case .editDevice(let device):
            if device.name?.count ?? 0 < 3 {
                state.deviceErrorMessage = .deviceName
                return
            }
            state.selectedDeviceID = ""
            state.deviceErrorMessage = .none
            state.service.updateDevice(
                device, completion: { result in
                    switch result {
                    case .deviceNameEditSuccess(let devices):
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.state.devices = devices
                        }
                    default:
                        print("디바이스 이름 바꾸기 실패")
                    }
                })
            state.devices = state.service.readDevice() ?? Device.dummy()
        case .deleteDevice:
            if state.selectedDeviceID != currentUDID {
                state.service.deleteDevice(state.selectedDeviceID, completion: { result in
                    switch result {
                    case .deviceDelete:
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.state.devices.removeAll(where: {
                                $0.udid == self.state.selectedDeviceID
                            })
                        }
                    default: break
                    }
                })
            } else {
                state.deviceErrorMessage = .notDeleteDevice
            }
        case .deviceInfoMode(let udid):
            state.deviceErrorMessage = .none
            if state.selectedDeviceID == udid {
                state.selectedDeviceID = ""
            } else {
                state.selectedDeviceID = udid
            }
        }
    }
}

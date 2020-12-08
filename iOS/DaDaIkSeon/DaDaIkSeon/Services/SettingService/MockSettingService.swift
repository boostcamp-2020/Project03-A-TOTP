//
//  SettingService.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

class MockSettingService: SettingServicable {
    
    private var user = DDISUser.dummy() // 나중에 userDefault로 변경해야함
    
    func loadUser() {
        user = DDISUser.dummy()
    }
    
    func refresh() {
        // 네트워크에서 가져오기
    }
    
    func readEmail() -> String? {
        return user.email
    }
    
    func updateEmail(_ email: String) {
        user.email = email
    }
    
    func updateBackupMode() {
        self.user.backup?.toggle()
    }
    
    func updateMultiDeviceMode() {
        self.user.multiDevice?.toggle()
    }
    
    func readDevice() -> [Device]? {
        user.device
    }
    
    func updateDevice(_ newDevice: Device) {
        guard let devices = user.device else { return }
        if let index = devices.firstIndex(where: { newDevice.udid == $0.udid }) {
            user.device?[index] = newDevice
        }
    }
    
    func deleteDevice(_ udid: String) {
        user.device?.removeAll(where: {
            $0.udid == udid
        })
    }
}

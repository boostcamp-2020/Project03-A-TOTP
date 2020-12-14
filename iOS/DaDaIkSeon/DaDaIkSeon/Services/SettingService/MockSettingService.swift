//
//  SettingService.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

class MockSettingService: SettingServiceable {

    private var user = DDISUser.dummy() // 나중에 userDefault로 변경해야함
    private var pincodeManager = PincodeManager()
    private var backupPasswordManager = BackupPasswordManager()
    
    init() {
        loadUser()
    }

    private func loadUser() { // 네트워크에서 가져와야한다. - 컴플리션에서 뷰 업데이트
        refresh()
    }
    // error: 설정 정보를 불러오는 데 실패하였습니다. 네트워크 연결을 확인해주세요.
    
    func refresh() {
        // 네트워크에서 가져오기
        user = DDISUser.dummy()
    }
    
    func readEmail() -> String? {
        return user.email
    }
    
    func updateEmail(_ email: String, completion: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager.shared
            .changeEmail(email: email) { [weak self] result in
                guard let self = self else { return }
                self.user.email = email
                completion(result)
            }
    }
    
    func updateBackupMode(_ udid: String,
                          backup: Bool,
                          updateView: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager.shared
            .changeBackupMode(udid: udid, backup: backup) { result in
            updateView(result)
        }
    }
    
    func readBackupPassword() -> String? {
        backupPasswordManager.loadPassword()
    }
    
    func updateBackupPassword(_ password: String) {
        backupPasswordManager.storePassword(password)
        // 백업 패스워드는 User 구조체에 들어가지 않는다.
        // 따로 UserDefault로 읽고 쓰고 변경해야 한다.
        // 나중에 토큰 가져올 때 이 비밀번호를 사용하여 복호화하게 된다.
    }
    
    func updateMultiDeviceMode(
        _ isOn: Bool, completion: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager
            .shared.changeMultiDevice(multiDevice: isOn) { result in
                completion(result)
        }
    }
    
    func readDevice() -> [Device]? {
        user.device
    }
    
    func updateDevice(_ newDevice: Device,
                      completion: @escaping (SettingNetworkResult) -> Void) {
        guard let devices = user.device else { return }
        
        // 업데이트 성공 응답을 받으면 그 때 view에 있는 디바이스 항목 업데이트
        if let index = devices.firstIndex(where: { newDevice.udid == $0.udid }) {
            user.device?[index] = newDevice
        }
        
    }
    
    func deleteDevice(_ udid: String,
                      completion: @escaping (SettingNetworkResult) -> Void) {
        
        user.device?.removeAll(where: {
            $0.udid == udid
        }) // 삭제 성공 응답을 받으면 그 때 view에 있는 디바이스 항목 업데이트
        
    }
    
    var pincode: String? {
        pincodeManager.loadPincode()
    }
    
    func deletePincode() {
        pincodeManager.deletePincode()
    }
    
    func createPincde(_ pincode: String) {
        pincodeManager.storePincode(pincode)
    }
}

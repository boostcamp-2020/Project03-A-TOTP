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
    private var networkManager = SettingNetworkManager()
    
    init() {
        // user default에서 가져온 값과 서버에서 받아온 값을 비교해서 최신으로 load한다?
        // 그냥 서버에서 데이터 받아서 사용하면 안되나? 꼭 유저 정보를 로컬에 가지고 있어야 할까
        loadUser()
    }

    private func loadUser() { // 유저 디폴트에서 가져와야한다.
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
    
    func updateBackupMode(_ udid: String, backup: Bool, updateView: @escaping  () -> Void) {
        networkManager.changeBackupMode(udid: udid, backup: backup) {
            updateView()
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
    
    func updateMultiDeviceMode(_ isOn: Bool, completion: () -> Void) {
        networkManager.changeMultiDevice(multiDevice: isOn, completion: {
            // result를 매개변수로 받아서 여기서 처리해준다.
            //self.user.multiDevice?.toggle() 이걸 success에서 실행
            // completion 이것도 success에서 실행
        })
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

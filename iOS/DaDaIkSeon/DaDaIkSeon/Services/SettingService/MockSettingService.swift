//
//  SettingService.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

class MockSettingService: SettingServiceable {
    
    private var user: DDISUser
    private var pincodeManager = PincodeManager()
    private var backupPasswordManager = BackupPasswordManager()
    
    init() {
        // 아래 로직을 placeholder에서 수행하도록 옮기자
        if let data = UserDefaults.standard.value(forKey: "DDISUser") as? Data {
            if let user = try? PropertyListDecoder().decode(DDISUser.self, from: data) {
                self.user = user
            } else {
                print("don't parsing")
                user = DDISUser.placeHoler()
            }
            print(data)
        } else {
            print("is not presented")
            user = DDISUser.placeHoler()
        }
    }
    
    func refresh(updateView: @escaping (SettingNetworkResult) -> Void) { // 뷰모델 생성자에서 실행
        UserNetworkManager.shared.load { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .refresh(var user):
                user.device = self.user.device
                self.user = user
                UserDefaults.standard.set(
                    try? PropertyListEncoder().encode(self.user), forKey: "DDISUser")
                updateView(result)
            default:
                updateView(result)
            }
        }
    }
    
    func readEmail() -> String? {
        return user.email
    }
    
    func updateEmail(_ email: String, completion: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager.shared
            .changeEmail(email: email) { [weak self] result in
                switch result {
                case .emailEdit:
                    guard let self = self else { return }
                    self.user.email = email
                    completion(result)
                default:
                    completion(result)
                }
                
            }
    }
    
    func updateBackupMode(_ udid: String,
                          backup: Bool,
                          updateView: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager.shared
            .changeBackupMode(udid: udid, backup: backup) {[weak self] result in
                guard let self = self else { return }
                self.user.device?.backup = true
                DDISUserCache.save(self.user)
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
        user.devices
    }
    
    func updateDevice(_ newDevice: Device,
                      completion: @escaping (SettingNetworkResult) -> Void) {
        guard let udid = newDevice.udid,
              let name = newDevice.name else { return }
        // 업데이트 성공 응답을 받으면 그 때 view에 있는 디바이스 항목 업데이트
        SettingNetworkManager.shared.changeDevice(
            udid: udid, name: name) { [weak self] result in
            switch result {
            case .deviceNameEdit:
                guard let self = self else { return }
                guard var devices = self.user.devices else {return}
                if let index = devices.firstIndex(where: { $0.udid == udid }) {
                    devices[index] = newDevice
                    completion(.deviceNameEditSuccess(devices))
                }
            default:
                print("deviceNameEdit 실패")
            }
        }
    }
    
    func deleteDevice(_ udid: String,
                      completion: @escaping (SettingNetworkResult) -> Void) {
        
        user.devices?.removeAll(where: {
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

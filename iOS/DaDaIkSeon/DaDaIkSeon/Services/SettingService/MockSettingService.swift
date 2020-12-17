//
//  SettingService.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

class MockSettingService: SettingServiceable {
    
//    /private var user: DDISUser? =
    private var pincodeManager = PincodeManager()
    private var backupPasswordManager = BackupPasswordManager()
    
    func refresh(updateView: @escaping (SettingNetworkResult) -> Void) { // 뷰모델 생성자에서 실행
        UserNetworkManager.shared.load { (result) in
            switch result {
            case .refresh(var serverUser):
                guard let user = DDISUserCache.get() else { return }
                // TODO: 서버에 있는 디바이스 중 내꺼 찾아서 받아오기
                serverUser.device = user.device
                DDISUserCache.save(serverUser)
                updateView(result)
            default:
                updateView(result)
            }
        }
    }
    
    func readEmail() -> String? {
        guard let user = DDISUserCache.get() else { return nil }
        return user.email
    }
    
    // userdefualt도 바꿔줘야 한다.
    func updateEmail(_ email: String, completion: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager.shared
            .changeEmail(email: email) { result in
                switch result {
                case .emailEdit:
                    guard var user = DDISUserCache.get() else { return }
                    user.email = email
                    DDISUserCache.save(user)
                    completion(result)
                default:
                    completion(result)
                }
            }
    }
    
    // userdefualt도 바꿔줘야 한다.
    func updateBackupMode(_ udid: String,
                          backup: Bool,
                          updateView: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager.shared
            .changeBackupMode(udid: udid, backup: backup) { result in
                switch result {
                case .backupToggle:
                    guard var user = DDISUserCache.get() else { return }
                    if var devices = user.devices {
                        if let index = devices.firstIndex(where: {
                            $0.udid ==  user.device?.udid
                        }) {
                            devices[index].backup = backup
                            user.devices = devices
                        }
                    }
                    user.device?.backup = backup
                    DDISUserCache.save(user)
                    updateView(result)
                default:
                    print("backupToggle 실패")
                }
                
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
    
    // userdefualt도 바꿔줘야 한다.
    func updateMultiDeviceMode(
        _ isOn: Bool, completion: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager
            .shared.changeMultiDevice(multiDevice: isOn) { result in
                switch result {
                case .multiDeviceToggle:
                    guard var user = DDISUserCache.get() else { return }
                    user.multiDevice = isOn
                    DDISUserCache.save(user)
                    completion(result)
                default:
                    print("changeMultiDevice 실패")
                }
            }
    }
    
    func readDevice() -> [Device]? {
        guard let user = DDISUserCache.get() else { return nil }
        return user.devices
    }
    
    // userdefualt도 바꿔줘야 한다.
    func updateDevice(_ newDevice: Device,
                      completion: @escaping (SettingNetworkResult) -> Void) {
        guard let udid = newDevice.udid,
              let name = newDevice.name else { return }
        // 업데이트 성공 응답을 받으면 그 때 view에 있는 디바이스 항목 업데이트
        SettingNetworkManager.shared.changeDevice(
            udid: udid, name: name) { result in
            switch result {
            case .deviceNameEdit:
                guard var user = DDISUserCache.get() else { return }
                guard var devices = user.devices else {return}
                if let index = devices.firstIndex(where: { $0.udid == udid }) {
                    devices[index] = newDevice
                    user.devices = devices
                    if newDevice.udid == user.device?.udid {
                        user.device = newDevice
                    } // device는 현재 디바이스 일 때만 바꾼다.
                    DDISUserCache.save(user)
                    completion(.deviceNameEditSuccess(devices))
                }
            default:
                print("deviceNameEdit 실패")
            }
        }
    }
    
    func deleteDevice(_ udid: String,
                      completion: @escaping (SettingNetworkResult) -> Void) {
        SettingNetworkManager.shared.deleteDevice(
            udid: udid) { result in
            guard var user = DDISUserCache.get() else { return }
            switch result {
            case .deviceDelete:
                user.devices?.removeAll(where: { // 서비스에서 삭제.
                    $0.udid == udid
                }) // 현재 디바이스 삭제는 ui에서 걸러준다.
                DDISUserCache.save(user)
                completion(result)
            default:
                completion(result)
            }
        }
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

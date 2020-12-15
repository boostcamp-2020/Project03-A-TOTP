//
//  SettingServicable.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

protocol SettingServiceable {

    func refresh(updateView: @escaping (SettingNetworkResult) -> Void) // 네트워크에서 가져오기
    
    func readEmail() -> String?
    func updateEmail(_ email: String,
                     completion : @escaping (SettingNetworkResult) -> Void)
    
    func updateBackupMode(_ udid: String, backup: Bool,
                           updateView: @escaping (SettingNetworkResult) -> Void)
    func readBackupPassword() -> String?
    func updateBackupPassword(_ password: String)
    
    func updateMultiDeviceMode(
        _ isOn: Bool, completion: @escaping (SettingNetworkResult) -> Void)
  
    func readDevice() -> [Device]?
    func updateDevice(
        _ newDevice: Device, completion: @escaping (SettingNetworkResult) -> Void)
    func deleteDevice(
        _ udid: String, completion: @escaping (SettingNetworkResult) -> Void)
    // - 디바이스 생성은 다른 디바이스에서 인증이 되었을 때 - 이건 로그인 화면에서 이루어지겠다!
    // 그럼 다른 디바이스에서 앱을 삭제하면?? - 이건 어쩔 도리가..
    
    var pincode: String? { get }
    func deletePincode()
    func createPincde(_ pincode: String)
}

//
//  SettingServicable.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

protocol SettingServicable {
    
    // 싱글톤 객체 사용
    // 네트워크 CRUD
    // UserDefault CRUD

    func loadUser() // 유저 디폴트에서 가져오기
    func refresh() // 네트워크에서 가져오기
    
    // 이메일
    func readEmail() -> String?
    func updateEmail(_ email: String)
    
    // 백업 on/off
    func updateBackupMode()
    
    // 멀티 디바이스 on/off
    func updateMultiDeviceMode()
    
    // 디바이스 CRUD
    // - 디바이스 생성은 다른 디바이스에서 인증이 되었을 때 - 이건 로그인 화면에서 이루어지겠다!
    //func createDevice()
    func readDevice() -> [Device]?
    func updateDevice(_ newDevice: Device)
    func deleteDevice(_ udid: String)
    
    // 그럼 다른 디바이스에서 앱을 삭제하면?? - 이건 어쩔 도리가..
    
}

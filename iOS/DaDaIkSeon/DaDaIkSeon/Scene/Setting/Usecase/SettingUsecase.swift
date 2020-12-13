//
//  SettingUsecase.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

struct SettingState {
    var service: SettingServiceable
    
    var email: String
    var emailEditMode: Bool
    var emailValidation: Bool
    
    var authEditMode: Bool
    
    var backupToggle: Bool
    var backupPasswordEditMode: Bool
    var backupPasswordEditCheckMode: Bool
    
    var editErrorMessage: SettingEditErrorMessage
    
    var deviceToggle: Bool
    var selectedDeviceID: String
    var deviceInfoMode: Bool
    
    var devices: [Device]
}

enum SettingInput {
    case refresh //
    
    case settingEmail(_ input: SettingEmail)
    
    case settingAuthMode(_ input: SettingEditAuth)
    
    case settingBackup(_ input: SettingBackup)
    
    case settingMultiDevice(_ input: SettingMultiDevice)
}

enum SettingEmail {
    case editEmailMode //
    case editEmail(_ email: String) //
}

enum SettingEditAuth {
    case editAuthMode
    case protectDaDaIkSeon(_ pincode: String)
    case liberateDaDaIkSeon
}

enum SettingBackup {
    case backupToggle //
    case editBackupPasswordMode
    case editBackupPassword(_ password: String)
    case checkPassword(_ last: String, _ check: String )
}

enum SettingMultiDevice {
    case multiDeviceToggle //
    case deviceInfoMode(_ udid: String) //
    case editDevice(_ device: Device)
    case deleteDevice
}

enum SettingEditErrorMessage: String {
    case none = ""
    case string = "비밀번호 형식이 올바르지 않습니다.(대소문자, 숫자, 6~15자 사이)"
    case different = "입력한 비밀번호와 일치하지 않습니다."
    case deviceName = "3자 이상의 이름을 입력해주세요."
    case notDeleteDevice = "현재 사용중인 디바이스는 삭제할 수 없습니다."
}

extension SettingView {
    
    final class SettingTransition: ObservableObject {
        
        @Published var newEmail = Entry(limit: 20)
        @Published var newPassword = Entry(limit: 15)
        @Published var newPasswordCheck = Entry(limit: 15)
        
        @Published var newDeviceName = Entry(limit: 10)
        
        @Published var faceIDToggle: Bool = false
        @Published var pinCodeSetting: Bool = false
        
        @Published var deviceAlert: Bool = false
    }
    
}

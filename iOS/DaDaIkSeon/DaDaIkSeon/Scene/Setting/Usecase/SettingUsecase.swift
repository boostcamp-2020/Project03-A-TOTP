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
    var deviceID: String
    var deviceInfoMode: Bool
    
    var devices: [Device]
}

enum SettingInput {
    case refresh
    
    case editEmailMode
    case editEmail(_ email: String)
    
    case editAuthMode
    
    case backupToggle
    case editBackupPasswordMode
    case editBackupPassword(_ password: String)
    case checkPassword(_ last: String, _ check: String )
    
    case multiDeviceToggle
    
    case deviceInfoMode(_ udid: String)
    
    case editDevice(_ device: Device)
    case deleteDevice(_ deviceID: String, _ myDeviceID: String)
    
    case protectDaDaIkSeon(_ pincode: String)
    case liberateDaDaIkSeon
}

enum SettingEditErrorMessage: String {
    case none = ""
    case stringSize = "글자 수가 모자랍니다."
    case different = "입력한 비밀번호와 일치하지 않습니다."
}

extension SettingView {
    
    final class SettingTransition: ObservableObject {
        @Published var newEmail: String = ""
        @Published var newPassword: String = ""
        @Published var newPasswordCheck: String = ""
        @Published var newDeviceName: String = ""
        @Published var faceIDToggle: Bool = false
        @Published var pinCodeSetting: Bool = false
    }
    
}

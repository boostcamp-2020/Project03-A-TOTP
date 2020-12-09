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
    
    var backupPasswordEditMode: Bool
    var backupPasswordEditCheckMode: Bool
    var backupPasswordErrorMessage: PasswordErrorMessage
    
    var deviceName: String
    var deviceInfoMode: Bool
    
    var devices: [Device]
}

enum SettingInput {
    case refresh
    
    case editEmailMode
    case editEmail(_ email: String)
    
    case backupToggle
    case editBackupPasswordMode
    case editBackupPassword(_ password: String)
    case checkPassword(_ last: String, _ check: String )
    
    case multiDeviceToggle
    
    case deviceInfoMode(_ name: String)
    
    case editDevice(_ device: Device)
    case deleteDevice(_ deviceID: String)
    
}

enum PasswordErrorMessage: String {
    case none = ""
    case stringSize = "글자 수가 모자랍니다."
    case different = "입력한 비밀번호와 일치하지 않습니다."
}

extension SettingView {
    
    final class SettingTransition: ObservableObject {
        @Published var backupToggle: Bool = false
        @Published var multiDeviceToggle: Bool = false
        @Published var newEmail: String = ""
        @Published var newPassword: String = ""
        @Published var newPasswordCheck: String = ""
        @Published var newDeviceName: String = ""
    }
    
}

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
    var devices: [Device]
}

enum SettingInput {
    case refresh
    
    case editEmail(_ email: String)
    
    case backupToggle
    case editBackupPassword(_ password: String)
    
    case multiDeviceToggle
    case editDevice(_ device: Device)
    case deleteDevice(_ deviceID: String)
}

extension SettingView {
    
    final class SettingTransition: ObservableObject {
        @Published var backupToggle: Bool = false
        @Published var multiDeviceToggle: Bool = false
    }
    
}

//
//  SettingNetworkResult.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/14.
//

import Foundation

enum SettingNetworkResult {
    case refresh(_ user: DDISUser)
    case emailEdit
    case multiDeviceToggle
    case backupToggle
    case deviceNameEdit
    case deviceDelete
    case accessError403
    case messageError
    case networkError
    case dataParsingError
    case ETCError500
    case ETCError
}

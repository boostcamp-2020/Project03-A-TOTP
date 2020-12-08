//
//  SettingUsecase.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

extension SettingView {
    final class SettingTransition: ObservableObject {
        // MARK: 화면 전환 또는 토글? - 새로운 화면에서 설정 해야 하는 것들
        // 백업 On/off 토글
        @Published var backupToggle: Bool = false
        // 멀티 디바이스 On/off 토글
        @Published var multiDeviceToggle: Bool = false
    }
}

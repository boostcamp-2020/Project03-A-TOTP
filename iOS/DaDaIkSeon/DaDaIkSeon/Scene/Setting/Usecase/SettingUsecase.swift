//
//  SettingUsecase.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

struct SettingState {
    var service: SettingServicable
    var email: String
    var devices: [Device]
}

enum SettingInput {
    // 완료 버튼
    
    // 리프레시 버튼
    case refresh
    // 누르면 정보 다 불러옴. - 라스트 데이트 검사 해서 최신 데이터로 업데이트
    
    // 내정보
    // 이메일 - 터치하면 수정 가능 해야 함. - 수정 후 서버 요청
    
    // 백업관리
    // 백업할래? - 토글 - 서버 요청 - on 하면 불러오기
    case backupToggle
    // 백업 비밀번호 변경 - '화면'필요
            // - 변경 후 요청
    
    // 기기관리
    // 멀티디바이스 - 토글
    case multiDeviceToggle
    // 리스트 셀 터치 - 변경 가능해야함 - '화면'필요
    
    // 삭제는 어떻게 하지?
}

extension SettingView {
    final class SettingTransition: ObservableObject {
        // MARK: 화면 전환 또는 토글? - 새로운 화면에서 설정 해야 하는 것들
        // 백업 On/off 토글
        @Published var backupToggle: Bool = false
        // 멀티 디바이스 On/off 토글
        @Published var multiDeviceToggle: Bool = false
    }
}

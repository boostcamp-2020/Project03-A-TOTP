//
//  BackupPasswordUsecase.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/15.
//

import Foundation

struct BackupPasswordState {
    var backupPassword = ""
    var backupPasswordChecker = ""
    var enable: Bool = false
    var next: Bool = false
    var errorMessage: BackupPasswordErrorMessage = .none
}

enum BackupPasswordInput {
    case inputPassword(_ input: String)
    case inputPasswordCheck(_ last: String, _ current: String)
    case next
}

enum BackupPasswordErrorMessage: String {
    case none = ""
    case inputFormat = "비밀 번호 형식이 올바르지 않습니다.(대소문자, 숫자, 6~15자 이내)"
    case isNotSame = "비밀번호가 일치하지 않습니다."
}

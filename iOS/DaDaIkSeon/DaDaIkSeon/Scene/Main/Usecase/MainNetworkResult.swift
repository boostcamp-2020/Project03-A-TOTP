//
//  MainNetworkResult.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/15.
//

import Foundation

enum MainNetworkResult {
    case successLoad(_ tokens: TokenNetworkType)
    case successSync
    case networkError
    case parsingError
    case noBackupPassword
    case failedEncryption
    case failedDecryption
    case serverHasNoTime
}

//

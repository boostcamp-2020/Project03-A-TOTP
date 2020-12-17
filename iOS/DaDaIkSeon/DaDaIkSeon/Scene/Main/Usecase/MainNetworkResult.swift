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
    case noBackupPassword(_ tokens: [Token])
    case failedEncryption
    case failedDecryption(_ tokens: [Token])
    case serverHasNoTime
    case noTokens
}

//

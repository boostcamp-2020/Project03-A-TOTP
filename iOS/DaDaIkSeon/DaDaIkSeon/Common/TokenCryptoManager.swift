//
//  StringCryptor.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import Foundation
import CryptoKit

class TokenCryptoManager {
    
    var password: String
    
    init(_ password: String) {
        self.password = password
    }
    
    func encrypt(with tokenKey: String) throws -> String {
        if let data = tokenKey.data(using: .utf8) {
            if let keyData = password.data(using: .utf8) {
                let key = SymmetricKey(data: SHA256.hash(data: keyData))
                if let cryptedBox = try? ChaChaPoly.seal(data, using: key) {
                    let sealBox = try? ChaChaPoly.SealedBox(combined: cryptedBox.combined)
                    if let box = sealBox {
                        return box.combined.base64EncodedString()
                    } else {
                        throw EncryptErrorType.sealBoxingError
                    }
                } else {
                    throw EncryptErrorType.sealError
                }
            } else {
                throw EncryptErrorType.passwordToDataError
            }
        } else {
            throw EncryptErrorType.tokenKeyToDataError
        }
    }
    
    func decrypt(from combinedStringData: String) throws -> String {
        if let combinedData = Data(base64Encoded: combinedStringData) {
            if let sealedBoxToOpen = try? ChaChaPoly.SealedBox(combined: combinedData) {
                if let keyData = password.data(using: .utf8) {
                    let key = SymmetricKey(data: SHA256.hash(data: keyData))
                    if let decrypedData = try? ChaChaPoly.open(sealedBoxToOpen, using: key) {
                        if let result = String(data: decrypedData, encoding: .utf8) {
                            return result
                        } else {
                            throw DecryptErrorType.decryptedDataToStringError
                        }
                    } else {
                        throw DecryptErrorType.decryptError
                    }
                } else {
                    throw DecryptErrorType.passwordToData
                }
            } else {
                throw DecryptErrorType.combinedToSealBoxError
            }
        } else {
            throw DecryptErrorType.combinedStringToDataError
        }
    }
    
    private enum EncryptErrorType: Error {
        case tokenKeyToDataError
        case passwordToDataError
        case sealError
        case sealBoxingError
    }
    private enum DecryptErrorType: Error {
        case combinedStringToDataError
        case combinedToSealBoxError
        case passwordToData
        case decryptError
        case decryptedDataToStringError
    }
    
}

//
//  TOTPGenerator.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/28.
//

import Foundation

final class TOTPGenerator {
    
    static var table: [String: UInt8] = [
        "A": 0, "B": 1, "C": 2, "D": 3, "E": 4, "F": 5, "G": 6, "H": 7,
        "I": 8, "J": 9, "K": 10, "L": 11, "M": 12, "N": 13, "O": 14, "P": 15,
        "Q": 16, "R": 17, "S": 18, "T": 19, "U": 20, "V": 21, "W": 22, "X": 23,
        "Y": 24, "Z": 25, "2": 26, "3": 27, "4": 28, "5": 29, "6": 30, "7": 31
    ]
    
    static func generate(from key: String) -> String? {
        var keyData: Data
        do {
            keyData = try decode32baseStringToData(base32String: key)
        } catch {
            return nil
        }
        
        guard let totp = DDISTOTP(
                key: keyData,
                digits: 6,
                timeInterval: 30) else {
            return nil
        }
        
        guard let password = totp.generateTOTP() else {
            return nil
        }
        return password
    }
    
    static func extractKey(from urlOfQrcode: String) -> String? {
        let items = URLComponents(string: urlOfQrcode)?.queryItems
        if let items = items {
            for index in items.indices
            where items[index].name == "secret" {
                return items[index].value
            }
        }
        return nil
    }
    
    static func decode32baseStringToData(base32String: String) throws -> Data {
        var base32String = base32String
        base32String = upper(string: base32String)
        
        var targetArray
            = try stringTo5bitBinaryStringArray(base32String: base32String)
        
        var target = targetArray.joined()
        
        let paddingSize = try getPaddingStringSize(from: base32String) // test
        
        (0..<paddingSize).forEach { _ in
            target.removeLast()
        }
        print("target", target)
        
        var resultArray = Array<UInt8>()
        try (0..<target.count / 8).forEach { _ in
            let lastIndex = target.index(target.startIndex, offsetBy: 8)
            let subString = String(target[target.startIndex..<lastIndex])
            target.removeSubrange(target.startIndex..<lastIndex)
            guard let resultInteger = UInt8(subString, radix: 2) else {
                throw TOTPGeneratorError.stringToUInt8Error
            }
            resultArray.append(resultInteger)
        }
        
        return Data(resultArray)
    }
    
    static func upper(string: String) -> String {
        string.uppercased()
    }
    
    static func stringTo5bitBinaryStringArray(base32String: String) throws -> [String] {
        return try base32String.map {
            guard let number = table[String($0)] else {
                throw TOTPGeneratorError.outOf32TableError
            }
            let binaryString = String(number, radix: 2)
            var prefixedZeros = String(repeatElement("0", count: (8 - binaryString.count))) + binaryString
            let lastIndex = prefixedZeros.index(prefixedZeros.startIndex, offsetBy: 3)
            prefixedZeros.removeSubrange(prefixedZeros.startIndex..<lastIndex)
            return prefixedZeros
        }
    }
    
    static func paddingSize(string: String) -> Int {
        string.filter { $0 == "=" }.count
    }
    
    static func getPaddingStringSize(from base32String: String) throws -> Int {
        
        var paddingStringSize = 0
        
        if base32String.hasSuffix("=") {
            let number = paddingSize(string: base32String) // 패딩 그룹 string만 넘겨주는 걸로 바꾸기
            switch number {
            case 1: paddingStringSize = 8
            case 3: paddingStringSize = 16
            case 4: paddingStringSize = 24
            case 6: paddingStringSize = 32
            default: throw TOTPGeneratorError.bufferSizeError
            }
        }
        return paddingStringSize
    }
    
    enum TOTPGeneratorError: Error {
        case extractKeyURLComponentsError
        case extractKeyNoSecretQueryError
        case outOf32TableError
        case bufferSizeError
        case stringToUInt8Error
    }
}

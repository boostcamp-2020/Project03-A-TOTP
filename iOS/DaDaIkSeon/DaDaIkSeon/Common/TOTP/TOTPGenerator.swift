//
//  TOTPGenerator.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/28.
//

import Foundation

final class TOTPGenerator {
    
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
    
    static var table: [String: UInt8] = [
        "A": 0, "B": 1, "C": 2, "D": 3, "E": 4, "F": 5, "G": 6, "H": 7,
        "I": 8, "J": 9, "K": 10, "L": 11, "M": 12, "N": 13, "O": 14, "P": 15,
        "Q": 16, "R": 17, "S": 18, "T": 19, "U": 20, "V": 21, "W": 22, "X": 23,
        "Y": 24, "Z": 25, "2": 26, "3": 27, "4": 28, "5": 29, "6": 30, "7": 31,
        "=": 0 // 이거 없으면 패딩있는 base32 스트링이 인풋으로 들어왔을 때 에러
    ]
    
    static func decode32baseStringToData(base32String: String) throws -> Data {
        
        let base32String = base32String.uppercased()
        
        var decoded5bitDataArray: [UInt8] = try base32String.map {
            if let uIntValue = table[String($0)] {
                return uIntValue
            } else {
                throw TOTPGeneratorError.outOf32TableError
            }
        }
        
        // 5bit array 이어붙이기
        var decoded8bitDataArray = concatenate(from: decoded5bitDataArray)
        
        // 패딩 개수 만큼 제거
        let lastGroupRange = base32String.index(base32String.endIndex, offsetBy: -8)...
        let lastGroupString = base32String[lastGroupRange]
        let paddingSize = calculatePaddingSize(from: String(lastGroupString))
        
        let removeRange = decoded8bitDataArray.index(decoded8bitDataArray.endIndex, offsetBy: -paddingSize)
        decoded8bitDataArray.removeSubrange(removeRange...)
        
        return Data(decoded8bitDataArray)
    }
    
    //static func lastGroup
    
    private static func calculatePaddingSize(from string: String) -> Int {
        let count = string.filter { $0 == "=" }.count
        switch count {
        case 1: return 1
        case 3: return 2
        case 4: return 3
        case 6: return 4
        default: return 0
        }
    }
    
    private static func concatenate(from array: [UInt8]) -> [UInt8] {
        var resultArray = [UInt8]()
        
        (0..<array.count / 8).forEach { groupSize in
            let groupIndex = groupSize * 8
            resultArray.append(contentsOf: [
                firstByte(first: array[groupIndex + 0], second: array[groupIndex + 1]),
                secondByte(second: array[groupIndex + 1], third: array[groupIndex + 2], fourth: array[groupIndex + 3]),
                thirdByte(fourth: array[groupIndex + 3], fifth: array[groupIndex + 4]),
                fourthByte(fifth: array[groupIndex + 4], sixth: array[groupIndex + 5], seventh: array[groupIndex + 6]),
                fifthByte(seventh: array[groupIndex + 6], eighth: array[groupIndex + 7])
            ])
        }
        
        return resultArray
    }
    
    // 첫글자 전부(0b00011111) + 두번째글짜의 앞 3비트(0b11111100)
    private static func firstByte(first: UInt8, second: UInt8) -> UInt8 {
        (first & 0b00011111) << 3 + (second & 0b00011100) >> 2
    }

    // 두번째 글자의 뒤 2비트(0b00011111) + 세번째 글자 전부(5개 비트)+ 네번째 글자의 맨 앞 1비트
    private static func secondByte(second: UInt8, third: UInt8, fourth: UInt8) -> UInt8 {
        ((second & 0b00000011) << 6) + (third << 1) + (fourth & 0b00010000) >> 4
    }

    // 네번째 글자의 4비트 + 다섯번째글자의 앞 4비트
    private static func thirdByte(fourth: UInt8, fifth: UInt8) -> UInt8  {
        (fourth & 0b00001111) << 4 + ((fifth & 0b00011110) >> 1)
    }

    // 다섯번째 글자의 1비트 + 여섯번째 글자 + 일곱번째 글자의 앞 2비트
    private static func fourthByte(fifth: UInt8, sixth: UInt8, seventh: UInt8) -> UInt8 {
        ((fifth & 0b00000001) << 7) + (sixth << 2) + ((seventh & 0b00011000) >> 3)
    }

    // 일곱번째 글자의 3비트 + 여덟번째 글자의 5비트
    private static func fifthByte(seventh: UInt8, eighth: UInt8) -> UInt8 {
        (seventh & 0b00000111) << 5 + eighth & 0b00011111
    }
    
    enum TOTPGeneratorError: Error {
        case extractKeyURLComponentsError
        case extractKeyNoSecretQueryError
        case outOf32TableError
        case bufferSizeError
        case stringToUInt8Error
    }
}

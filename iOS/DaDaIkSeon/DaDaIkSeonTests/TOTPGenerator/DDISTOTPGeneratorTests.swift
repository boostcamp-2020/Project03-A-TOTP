//
//  DDISTOTPGeneratorTests.swift
//  DaDaIkSeonTests
//
//  Created by 정재명 on 2020/12/06.
//

import XCTest
import SwiftOTP

class DDISTOTPGenerationTests: XCTestCase {
    
    var table: [String: UInt8] = [
        "A": 0, "B": 1, "C": 2, "D": 3, "E": 4, "F": 5, "G": 6, "H": 7,
        "I": 8, "J": 9, "K": 10, "L": 11, "M": 12, "N": 13, "O": 14, "P": 15,
        "Q": 16, "R": 17, "S": 18, "T": 19, "U": 20, "V": 21, "W": 22, "X": 23,
        "Y": 24, "Z": 25, "2": 26, "3": 27, "4": 28, "5": 29, "6": 30, "7": 31
    ] // 32개.
    
    // MARK: URL
    let github = "otpauth://totp/GitHub:jjm159?secret=WEJ3NLTTYHF4XVXG&issuer=GitHub"
    let google = "otpauth://totp/Google%3Awjdwoaud15%40gmail.com?secret=fn3gdedtxfsluaz4qlcv7ndhowimn4h2&issuer=Google"
    
    var urlList: [String] {
        [github, google]
    }
    
    func test_base32_맞는지테스트() throws {
        do {
            guard let keyData = base32DecodeToData(try extractKey(from: github)) else {
                XCTFail()
                return
            }
            // 이 값과 같으면 성공
            print(try decode32baseStringToData(url: github), keyData)
            
            XCTAssertEqual(try decode32baseStringToData(url: github), keyData)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_upper() {
        urlList.forEach {
            do {
                let key = try extractKey(from: $0)
                upper(string: key).forEach {
                    if !($0.isUppercase || $0.isNumber) {
                        print($0)
                        XCTFail("소문자 있음")
                    }
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
    func testStringRadix() {
        XCTAssertEqual( "10000", String(16, radix: 2))
    }
    
    func test_subString() {
        var resultString = "123456789"
        let lastIndex = resultString.index(resultString.startIndex, offsetBy: 8)
        let subString = resultString[resultString.startIndex..<lastIndex]
        resultString.removeSubrange(resultString.startIndex..<lastIndex)
        XCTAssertEqual(String(subString), "12345678")
        XCTAssertEqual(resultString, "9")
    }
    
    func test_stringTo5bitBinaryStringArray() throws {
        let source = "ABCDE" // 00000 00001 00002 00003 00004
        XCTAssertEqual(["00000","00001","00010","00011","00100"],
                       try stringTo5bitBinaryStringArray(base32String: source))
    }
    
}

extension DDISTOTPGenerationTests {
    
    func extractKey(from urlOfQrcode: String) throws -> String {
        let items = URLComponents(string: urlOfQrcode)?.queryItems
        if let items = items {
            for index in items.indices
            where items[index].name == "secret" {
                if let result =  items[index].value {
                    return result
                }
                throw TOTPGeneratorError.extractKeyNoSecretQueryError
            }
        }
        throw TOTPGeneratorError.extractKeyURLComponentsError
    }
    
    func upper(string: String) -> String {
        string.uppercased()
    }
    
    func stringTo5bitBinaryStringArray(base32String: String) throws -> [String] {
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
    
    func paddingSize(string: String) -> Int {
        string.filter { $0 == "=" }.count
    }
    
    func getPaddingStringSize(from base32String: String) throws -> Int {
        
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
    
    func decode32baseStringToData(url: String) throws -> Data {
        
        var base32String = try extractKey(from: url)
        
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
    
    enum TOTPGeneratorError: Error {
        case extractKeyURLComponentsError
        case extractKeyNoSecretQueryError
        case outOf32TableError
        case bufferSizeError
        case stringToUInt8Error
    }
}

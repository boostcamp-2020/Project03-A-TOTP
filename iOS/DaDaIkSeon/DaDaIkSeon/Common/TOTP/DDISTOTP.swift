//
//  TOTP.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/20.
//

import Foundation
import CryptoKit

struct DDISTOTP {
    
    public let key: Data
    public let digits: Int
    public let timeInterval: Int
    
    init?(key: Data, digits: Int, timeInterval: Int) {
        self.key = key
        self.digits = digits
        self.timeInterval = timeInterval
        guard self.validateDigits(digit: digits) else { return nil }
    }
    
    func generateTOTP() -> String? {
        let secret = keyToArray(key)
        guard let realCounterMessage = timeToData() else {
            return nil
        }
        let hmacHash = HMAC<Insecure.SHA1>.authenticationCode(
            for: realCounterMessage, using: SymmetricKey(data: secret))
        let number = truncate(hash: hmacHash)
        return numberToPasswordString(number)
    }

    func keyToArray(_ data: Data) -> [UInt8] {
        Array<UInt8>(data)
    }

    func timeToData() -> [UInt8]? {
        // Time 전처리
        let secondsPast1970 = Int(Date().timeIntervalSince1970)
        guard validateTime(time: secondsPast1970) else { return nil }
        
        let counterValue = Int(floor(Double(secondsPast1970) / Double(timeInterval)))
        
        // UInt64를 bigEndian으로 바꾸고 64비트씩 잘라서 바이너리 데이터로 만들어준다.
        var bigEndianNumber = UInt64(counterValue).bigEndian
        let counterData = Data(bytes: &bigEndianNumber, count: MemoryLayout.size(ofValue: bigEndianNumber))
        return Array<UInt8>(counterData)
    }

    func truncate(hash: HashedAuthenticationCode<Insecure.SHA1>) -> UInt32 {
        // 변환
        let hmac = Array<UInt8>(hash)
        
        // 4비트 구함
        let offset = Int((hmac.last ?? 0x00) & 0x0f)
        
        // offset을 사용해서 4바이트 추출
        let truncatedHMAC = Array(hmac[offset...offset + 3]) // 4byte 데이터임
        
        // UInt32로 변환
        var number = truncatedHMAC.reduce(UInt32(0)) { (lastValue, oneByteValue) -> UInt32 in
            print(lastValue, oneByteValue)
            return (lastValue << 8) + UInt32(oneByteValue)
        }
        
        // 부호 비트를 0으로 만들어준다. - 아래 스트링에서 값이 이상하게 변할지도!
        number &= 0x7fffffff
        
        // Modulo number by 10^(digits)
        return number % UInt32(pow(10, Float(digits)))
    }

    func numberToPasswordString(_ number: UInt32) -> String? {
        // Convert int to string
        let strNum = String(number)
        var result = ""
        // Return string if adding leading zeros is not required
        if strNum.count == digits {
            result = strNum
        }
        // Add zeros to start of string if not present and return
        let prefixedZeros = String(repeatElement("0", count: (digits - strNum.count)))
        result = (prefixedZeros + strNum)
        return result
    }
    
    private func validateDigits(digit: Int) -> Bool {
        let validDigits = 6...8
        return validDigits.contains(digit)
    }

    private func validateTime(time: Int) -> Bool {
        return (time > 0)
    }
}

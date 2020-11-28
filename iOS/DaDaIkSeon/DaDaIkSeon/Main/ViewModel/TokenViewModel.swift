//
//  TokenViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation
import Combine
import CryptoKit

final class TokenViewModel: ObservableObject {
    
    // MARK: Property
    @Published var token: Token
    @Published var showEditView = false
    
    var key: String {
        guard let key = token.key else {
            return ""
        }
        return key
    }
    
    @Published var color = "pink"
    @Published var password = ""
    
    let totalTime = TOTPTimer.shared.totalTime
    let timerInterval = TOTPTimer.shared.timerInterval
    
    var subscriptions = Set<AnyCancellable>()
    
    var lastSecond: Int = 1
      
    // MARK: init
    
    init(token: Token) {
        
        self.token = token
        self.color = token.color ?? "pink"
          
        password = makePassword(key: key)
        
        TOTPTimer.shared.timer
            .map({ (output) in
                output.timeIntervalSince1970
            })
            .map({ (timeInterval) in
                Int(timeInterval.truncatingRemainder(dividingBy: self.totalTime))
            })
            .sink { [weak self] (seconds) in
                guard let weakSelf = self else { return }
                if weakSelf.lastSecond != seconds {
                    if seconds == 0 {
                        weakSelf.password
                            = weakSelf.makePassword(key: weakSelf.key)
                    }
                    weakSelf.lastSecond = seconds
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: Action
    
    func editButtonDidTab() {
        print("EditButtonDidTab")
    }
    
    func copyButtonDidTab() {
        print("CopyButtonDidTab")
    }
    
    // MARK: Logic
    
    func makePassword(key: String) -> String {
        
        let period = TimeInterval(totalTime)
        let digits = 6
        
        // 키 값
        guard let secret = Data(base64Encoded: key) else {
            return "000000"
        }
        
        // 현재 시간
        var counter = UInt64(Date().timeIntervalSince1970 / period).bigEndian
        let counterData = withUnsafeBytes(of: &counter) { Array($0) }
        
        // HMAC 알고리즘 연산
        let hash = HMAC<Insecure.SHA1>.authenticationCode(
            for: counterData, using: SymmetricKey(data: secret))
        
        // 추출
        var truncatedHash = hash.withUnsafeBytes { ptr -> UInt32 in
            let offset = ptr[hash.byteCount - 1] & 0x0f
            guard let baseAddress = ptr.baseAddress else { return 0 }
            let truncatedHashPtr = baseAddress + Int(offset)
            return truncatedHashPtr.bindMemory(to: UInt32.self, capacity: 1).pointee
        }
        
        truncatedHash = UInt32(bigEndian: truncatedHash)
        truncatedHash = truncatedHash & 0x7FFF_FFFF
        truncatedHash = truncatedHash & UInt32(pow(10, Float(digits)))
        
        return "\(String(format: "%0*u", digits, truncatedHash))"
    }
    
}

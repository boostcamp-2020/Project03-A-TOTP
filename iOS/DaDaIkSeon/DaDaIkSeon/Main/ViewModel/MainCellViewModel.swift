//
//  MainCellViewModel.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/25.
//

import Foundation
import CryptoKit
import Combine

class MainCellViewModel: ObservableObject {
    
    /// MARK: Model
    /// 토큰 모델? -> 여기에 컬러, 아이콘, 키 값, 이름 정보가 있음.
    /// 토큰을 바인딩하고 있는 게 편할 것 같다. 여기서 수정해도 바로 원본이 수정되니까!
    // MARK: 토큰 값을 viewmodel이 가지고 있을 필요가 없다. 그냥 토큰에서 필요한 값만 가져와 published에 할당하면 끝! 셀 데이터를 수정하게 되면, 전역적으로 접근 가능한 mainviewmodel의 tokens의 값을 변경시켜주면 된다.
    
    // MARK: Property
    
    // 토큰 모델에서 값 가져와야한다.
    let key = "6UAOpz+x3dsNrQ=="
    
    @Published var tokenName = "토큰의이름은두줄두줄두줄두줄두줄두줄두줄두줄두줄"
    
    @Published var timeString = "1"
    @Published var timeAmount = 0.0
    @Published var password = ""
    
    let totalTime = TOTPTimer.shared.totalTime
    let timerInterval = TOTPTimer.shared.timerInterval
    
    var subscriptions = Set<AnyCancellable>()
    
    var lastSecond: Int = 1
    
    init() {
        
        password = makePassword(key: key)
        
        timeAmount
            = Date().timeIntervalSince1970
            .truncatingRemainder(dividingBy: totalTime) + 1
        
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
                    weakSelf.timeString = "\(seconds + 1)"
                    if seconds == 0 {
                        weakSelf.password
                            = weakSelf.makePassword(key: weakSelf.key)
                        weakSelf.timeAmount = 0
                    }
                    weakSelf.lastSecond = seconds
                }
                weakSelf.timeAmount += weakSelf.timerInterval
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

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
    
    // MARK: Model
    // 토큰 모델? -> 여기에 컬러, 아이콘, 키 값, 이름 정보가 있음.
    // 토큰을 바인딩하고 있는 게 편할 것 같다. 여기서 수정해도 바로 원본이 수정되니까!
    
    // MARK: Property
    
    // 토큰 모델에서 값 가져와야한다.
    let key = "6UAOpz+x3dsNrQ=="
    
    @Published var tokenName = "토큰의이름은두줄두줄두줄두줄두줄두줄두줄두줄두줄"
    
    @Published var timeString = "1"
    @Published var timeAmount = 0.0
    @Published var password = ""
    
    let totalTime = 3.0
    let timerInterval = 0.01
    
    var subscriptions = Set<AnyCancellable>()
    
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    var lastSecond: Int = 1
    
    let todaySartTime = { () -> Date? in
        let dateFormmater = DateFormatter()
        dateFormmater.locale = Locale(identifier: "ko_KR")
        dateFormmater.dateFormat = "yyyy-MM-dd"
        let today = dateFormmater.string(from: Date())
        return dateFormmater.date(from: today)
    }()
    
    init() {
        timer = Timer.publish(every: timerInterval, on: .main, in: .common)
            .autoconnect()
        password = makePassword(key: key)
        
        timeAmount
            = -Double(todaySartTime?.timeIntervalSinceNow ?? 0)
            .truncatingRemainder(dividingBy: totalTime) + 1
        
        timer
            .map({ (output) in
                return output.timeIntervalSince(self.todaySartTime ?? Date())
            })
            .map({ (timeInterval) in
                return Int(timeInterval) % Int(self.totalTime)
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
        let secret = Data(base64Encoded: key)!
        
        // 현재 시간
        var counter = UInt64(Date().timeIntervalSince1970 / period).bigEndian
        let counterData = withUnsafeBytes(of: &counter) { Array($0) }
        
        // HMAC 알고리즘 연산
        let hash = HMAC<Insecure.SHA1>.authenticationCode(
            for: counterData, using: SymmetricKey(data: secret))
        
        // 추출
        var truncatedHash = hash.withUnsafeBytes { ptr -> UInt32 in
            let offset = ptr[hash.byteCount - 1] & 0x0f
            let truncatedHashPtr = ptr.baseAddress! + Int(offset)
            return truncatedHashPtr.bindMemory(to: UInt32.self, capacity: 1).pointee
        }
        
        truncatedHash = UInt32(bigEndian: truncatedHash)
        truncatedHash = truncatedHash & 0x7FFF_FFFF
        truncatedHash = truncatedHash & UInt32(pow(10, Float(digits)))
        
        return "\(String(format: "%0*u", digits, truncatedHash))"
    }
    
}

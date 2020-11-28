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
    
    // MARK: 토큰 값을 viewmodel이 가지고 있을 필요가 없다. 그냥 토큰에서 필요한 값만 가져와 published에 할당하면 끝! 셀 데이터를 수정하게 되면, 전역적으로 접근 가능한 mainviewmodel의 tokens의 값을 변경시켜주면 된다.
    
    // MARK: Property
    
    // 토큰 모델에서 값 가져와야한다.
    let key = "WEJ3NLTTYHF4XVXG"
    
    @Published var tokenName = "토큰의이름은두줄두줄두줄두줄두줄두줄두줄두줄두줄"
    
    @Published var timeString = "1"
    @Published var timeAmount = 0.0
    @Published var password = ""
    
    let totalTime = TOTPTimer.shared.totalTime
    let timerInterval = TOTPTimer.shared.timerInterval
    
    var subscriptions = Set<AnyCancellable>()
    
    var lastSecond: Int = 1
    
    init() {
        
        password = TOTPGenerator.generate(from: key) ?? "000000"
        
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
                            = TOTPGenerator.generate(from: weakSelf.key) ?? "000000"
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
    
}

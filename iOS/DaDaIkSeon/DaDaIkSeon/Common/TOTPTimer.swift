//
//  TOTPTimer.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/28.
//

import Foundation
import Combine

class TOTPTimer {
    
    let totalTime = 30.0
    let timerInterval = 0.01
    
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    static var shared = TOTPTimer()
    
    private init() {
        
        timer = Timer
            .publish(every: timerInterval, on: .main, in: .common)
            .autoconnect()
        
    }
}

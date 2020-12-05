//
//  TOTPTimer.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/28.
//

import Foundation
import Combine

final class TOTPTimer {
    
    let totalTime = 30.0
    let timerInterval = 0.01
    
    static var shared = TOTPTimer()
    
    var subscribers = [(Publishers.Autoconnect<Timer.TimerPublisher>) -> Void]()
    
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    private init() {
        timer = Timer
            .publish(every: timerInterval, on: .main, in: .common)
            .autoconnect()
    }
    
    func start(subscriber: @escaping (Publishers.Autoconnect<Timer.TimerPublisher>) -> Void) {
        subscribers.append(subscriber)
        subscriber(timer)
    }
    
    func startAll() { // 클로저에 있는 모든 액션 실행
        subscribers.forEach { $0(timer) }
    }
    
    func cancel() { // 타이머의 upstream을 닫음. 모든 subscriber 구독 중지.
        timer.upstream.connect().cancel()
    }
    
}

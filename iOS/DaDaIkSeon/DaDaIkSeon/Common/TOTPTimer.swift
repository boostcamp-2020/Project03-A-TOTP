//
//  TOTPTimer.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/28.
//

import Foundation
import Combine

final class TOTPTimer {
    
    typealias TimerPublisher = Publishers.Autoconnect<Timer.TimerPublisher>
    
    let totalTime = 30.0
    let timerInterval = 0.01
    
    static var shared = TOTPTimer()
    
    let timer: TimerPublisher
    
    var subscribers = [UUID: (TimerPublisher) -> Void]()
    
    private init() {
        timer = Timer
            .publish(every: timerInterval, on: .main, in: .common)
            .autoconnect()
    }
    
    func start(tokenID: UUID, subscriber: @escaping (TimerPublisher) -> Void) {
        subscribers.updateValue(subscriber, forKey: tokenID)
        subscriber(timer)
    }
    
    func startAll() { // 클로저에 있는 모든 액션 실행
        subscribers.forEach { $0.value(timer) }
    }
    
    func cancel() { // 타이머의 upstream을 닫음. 모든 subscriber 구독 중지.
        timer.upstream.connect().cancel()
    }
    
    func deleteSubscribers(tokenIDs: [UUID]) {
        tokenIDs.forEach {
            subscribers.removeValue(forKey: $0)
        }
    }
    
}

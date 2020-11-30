//
//  TokenCellViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/30.
//

import Foundation
import Combine

final class TokenCellViewModel: ViewModel {
    
    // MARK: Property
    
    @Published var state: TokenCellState
    
    var totalTime = TOTPTimer.shared.totalTime
    let timerInterval = TOTPTimer.shared.timerInterval
    
    var subscriptions = Set<AnyCancellable>()
    var lastSecond: Int = 1
    
    init(service: TokenServiceable, token: Token) {
        state = TokenCellState(service: service,
                               token: token,
                               isShownEditView: false,
                               password: TOTPGenerator.generate(from: token.key ?? "") ?? "000000",
                               leftTime: "1",
                               timeAmount: 0.0)
        timeAmount = countTimeBy30 + 1
        
        initTimer(key: token.key ?? "")
    }
    
    // MARK: Methods
    
    func trigger(_ input: TokenCellInput) {
        switch input {
        case .showEditView:
            state.isShownEditView = true
        }
    }
    
}

extension TokenCellViewModel {
    
    func initTimer(key: String) {
        TOTPTimer.shared.timer
            .map({ (output) in
                output.timeIntervalSince1970
            })
            .map({ [weak self] (timeInterval) -> Int in
                guard let weakSelf = self else { return 0 }
                return Int(
                    timeInterval.truncatingRemainder(dividingBy: weakSelf.totalTime))
            })
            .sink { [weak self] (seconds) in
                guard let weakSelf = self else { return }
                weakSelf.updatePassword(seconds: seconds, key: key)
                weakSelf.updateTimeAmount()
            }
            .store(in: &subscriptions)
    }
   
    func updatePassword(seconds: Int, key: String) {
        if lastSecond != seconds {
            leftTime = "\(seconds + 1)"
            if seconds == 0 {
                password
                    = TOTPGenerator.generate(from: key) ?? "000000"
                resetTimeAmount()
            }
            lastSecond = seconds
        }
    }
    
    func resetTimeAmount() {
        timeAmount = 0
    }
    
    func updateTimeAmount() {
        timeAmount += timerInterval
    }
    
    var countTimeBy30: Double {
        Date().timeIntervalSince1970
        .truncatingRemainder(dividingBy: totalTime)
    }
    
    var service: TokenServiceable {
        get { state.service }
        set { state.service = newValue }
    }
    
    var token: Token {
        get { state.token }
        set { state.token = newValue }
    }
    
    var isShownEditView: Bool {
        get { state.isShownEditView }
        set { state.isShownEditView = newValue }
    }
    
    var password: String {
        get { state.password }
        set { state.password = newValue }
    }
    
    var leftTime: String {
        get { state.leftTime }
        set { state.leftTime = newValue }
    }
    
    var timeAmount: Double {
        get { state.timeAmount }
        set { state.timeAmount = newValue }
    }
    
}

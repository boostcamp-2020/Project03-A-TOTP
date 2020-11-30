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
    
    let totalTime = TOTPTimer.shared.totalTime
    let timerInterval = TOTPTimer.shared.timerInterval
    
    var subscriptions = Set<AnyCancellable>()
    var lastSecond: Int = 1
    
    init(service: TokenServiceable, token: Token) {
        state = TokenCellState(service: service,
                               token: token,
                               isShownEditView: false,
                               password: TOTPGenerator.generate(from: token.key ?? "") ?? "000000")
        
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
                        weakSelf.state.password
                            = TOTPGenerator.generate(from: token.key ?? "") ?? "000000"
                    }
                    weakSelf.lastSecond = seconds
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: Methods
    
    func trigger(_ input: TokenCellInput) {
        switch input {
        case .showEditView:
            state.isShownEditView = true
        }
    }
    
}

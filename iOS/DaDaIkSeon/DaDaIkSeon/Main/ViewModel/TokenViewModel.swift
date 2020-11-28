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
          
        password = TOTPGenerator.generate(from: key) ?? "000000"
        
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
                            = TOTPGenerator.generate(from: weakSelf.key) ?? "000000"
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
    
}

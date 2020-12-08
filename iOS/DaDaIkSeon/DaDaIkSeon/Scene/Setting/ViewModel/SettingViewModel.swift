//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

class SettingViewModel: ViewModel {
    
    @Published var state: SettingState
    
    init() {
        state = SettingState(service: MockSettingService())
    }
  
    func trigger(_ input: SettingInput) {
    
    }
    
}

//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import Foundation

struct SettingState {
    
}

enum SettingInput {
    
}

class SettingViewModel: ViewModel {
    
    @Published var state = SettingState()
    
    init() {
        
    }
  
    func trigger(_ input: SettingInput) {
    
    }
    
}

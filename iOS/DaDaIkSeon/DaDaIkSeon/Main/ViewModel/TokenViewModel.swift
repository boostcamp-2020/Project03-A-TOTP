//
//  TokenViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation

class TokenViewModel: ObservableObject {
    
    @Published var token: Token
    
    init(token: Token) {
        self.token = token
    }
    
}

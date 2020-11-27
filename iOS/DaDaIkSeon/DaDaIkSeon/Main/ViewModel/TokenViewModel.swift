//
//  TokenViewModel.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import Foundation

final class TokenViewModel: ObservableObject {
    
    // MARK: Property
    
    @Published var token: Token
    @Published var showEditView = false
    
    // MARK: init
    
    init(token: Token) {
        self.token = token
    }
    
}

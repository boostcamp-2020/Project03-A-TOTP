//
//  DaDaIkSeonApp.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

@main
struct DaDaIkSeonApp: App {
    
    let service = TokenService()
    
    var body: some Scene {
        WindowGroup {
            MainView(service: service)
        }
    }
}

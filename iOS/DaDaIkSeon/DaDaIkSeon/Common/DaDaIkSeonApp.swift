//
//  DaDaIkSeonApp.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

@main
struct DaDaIkSeonApp: App {
    
    var body: some Scene {
        let storageManager = StorageManager()
        let service = TokenService(storageManager)
        
        WindowGroup {
            MainView(service: service).environmentObject(NavigationFlowObject())
        }
    }
    
}

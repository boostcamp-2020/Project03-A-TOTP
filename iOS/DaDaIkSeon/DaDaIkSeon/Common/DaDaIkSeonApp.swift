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
        
        #if DEBUG

        let service = MockTokenService()
        let loginService = LoginService()

        #else
        
        let storageManager = StorageManager()
        let service = TokenService(storageManager)
        
        #endif
        
        WindowGroup {
            NavigationView {
                SettingView()
            }
            //MainView(service: service).environmentObject(NavigationFlowObject())
        }
    }
    
}

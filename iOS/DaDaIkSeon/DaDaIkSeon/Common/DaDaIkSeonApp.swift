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
        let loginService = LoginService()
        
        #endif
        
        WindowGroup {
            //MainView(service: service).environmentObject(NavigationFlowObject())
          
//            LoginView(service: loginService)
            NavigationView {
                SettingView()
            }
        }
    }
    
}

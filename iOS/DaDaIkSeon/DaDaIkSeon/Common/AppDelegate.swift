//
//  AppDelegate.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/13.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        clearKeychainIfWillUnistall()
        return true
    }
    
    func clearKeychainIfWillUnistall() {
        let freshInstall = !UserDefaults.standard.bool(forKey: "alreadyInstalled")
        if freshInstall {
            _ = StorageManager().deleteTokens()
            _ = PincodeManager().deletePincode()
            _ = JWTTokenStoreManager().delete()
            UserDefaults.standard.set(true, forKey: "alreadyInstalled")
        }
    }
}

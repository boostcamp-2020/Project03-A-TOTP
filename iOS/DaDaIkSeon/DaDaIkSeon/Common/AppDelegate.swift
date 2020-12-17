//
//  AppDelegate.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/13.
//

import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        checkDeviceID()
        clearKeychainIfWillUnistall()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(true,
                                  forKey: "isEmailView")
    }
    
    func checkDeviceID() {
        if DeviceIDManager().load() == nil {
            let deviceID = UUID().uuidString
            DeviceIDManager().store(deviceID)
        }
    }
    
    func clearKeychainIfWillUnistall() {
        let freshInstall = !UserDefaults.standard.bool(forKey: "alreadyInstalled")
        if freshInstall {
            _ = StorageManager().deleteTokens()
            _ = PincodeManager().deletePincode()
            _ = JWTTokenStoreManager().delete()
            _ = BackupPasswordManager().deletePassword()
            UserDefaults.standard.set(true, forKey: "alreadyInstalled")
        }
    }
}

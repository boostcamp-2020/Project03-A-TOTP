//
//  DaDaIkSeonApp.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

@main
struct DaDaIkSeonApp: App {
    
    @State var main = false
    @State var pincode = false
    
    var pincodeManager = PincodeManager()
    var bioAuth = BiometricIDAuth()
    
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        
        let storageManager = StorageManager()
        let service = TokenService(storageManager)
        
        WindowGroup {
            // 아래에서 상태 만들고 여기서 조건문으로 분기
            
            // 각 뷰의 상태값을 만듬
            // 조건문에 따라 다른 뷰 생성
            
            if main {
                MainView(service: service).environmentObject(NavigationFlowObject())
            } else if pincode {
                if let pincode = pincodeManager.loadPincode() {
                    PinCodeView(mode: .auth(pincode), completion: { _ in
                        self.pincode = false
                        main = true
                    })
                }
            }
            // 대체 화면이 있어야 하나? - 배경을 달아놓을까?
        }
        .onChange(of: scenePhase, perform: { newScenePhrase in
            switch newScenePhrase {
            case .active:
                guard !main && !pincode else { return } // 하나라도 true면 실행 못하게
                // jwt를 핀코드보다 먼저 검사해야할지 고민
                if let pincode = pincodeManager.loadPincode() {
                    bioAuth.authenticateUser { result in
                        if result == nil { // 생체인증 성공
                            print("성공")
                            DispatchQueue.main.async {
                                main = true
                            }
                        } else {
                            if "You pressed cancel." == result
                                || "You pressed password." == result {
                                print("cancel", "실패, 핀넘버로")
                                DispatchQueue.main.async {
                                    self.pincode = true
                                }
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.main = true // pincode 없으면 앱 보호 안하겠다는 것
                    }
                }
            default: break
            }
        })
        
    }
    
}

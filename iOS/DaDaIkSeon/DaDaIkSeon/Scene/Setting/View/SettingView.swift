//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: ViewModel
    @ObservedObject var viewModel: AnyViewModel<SettingState, SettingInput>
    
    // MARK: Property
    @ObservedObject var stateManager = SettingTransition()
    
    @ObservedObject var linkManager: MainLinkManager
    
    init(linkManager: ObservedObject<MainLinkManager>) {
        let udid = StorageManager<String>(type: .deviceID).load() ?? ""
        // udid 없으면 error처리, 기기정보를 읽을 수 없다고
        viewModel = AnyViewModel(SettingViewModel(udid: udid ?? ""))
        self._linkManager = linkManager
        if nil != viewModel.state.service.pincode {
            stateManager.faceIDToggle = true
        }
        // 이런식으로 다 초기화해줘야한다! - 네트워크에서 받아온걸로!
    }
    
    var body: some View {
        SettingViewWrapper(linkManager: _linkManager, action: {
            viewModel.trigger(.refresh)
        }, content: {
            Spacer().frame(height: 10)
            
            // MARK: 내정보 관리
            myInfoView
            #if DEBUG
            // MARK: 백업 관리
            backupView
            
            // MARK: 기기 관리
            deviceSettingView
            
            #endif
            Spacer()
        })
        .fullScreenCover(isPresented: $stateManager.pinCodeSetting) {
            stateManager.faceIDToggle ?
                PinCodeView(
                    mode: .delete(viewModel.state.service.pincode ?? "0000"),
                    completion: { _ in
                        viewModel.trigger(.settingAuthMode(.liberateDaDaIkSeon))
                        stateManager.faceIDToggle.toggle()})
                :PinCodeView(mode: .setup, completion: { pincode in
                    viewModel.trigger(.settingAuthMode(.protectDaDaIkSeon(pincode)))
                    stateManager.faceIDToggle.toggle()
                })
        }
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.trigger(.refresh)
            stateManager.reset()
        }
    }
}

//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: 뷰모델
    @ObservedObject var viewModel = SettingViewModel()
    
    // MARK: 화면 전환 또는 토글? - 새로운 화면에서 설정 해야 하는 것들
    // 생체 인식, 핀넘버 사용
    @State var securitySetting: Bool = false
    // 이메일 변경
    @State var emailSetting: Bool = false
    // 디바이스 정보 변경
    @State var deviceSetting: Bool = false
    
    // MARK: 진짜 상태값 State
    @State var backupMode: Bool = false
    @State var multiDeviceMode: Bool = false
    @State var devices = Device.dummy() // 서비스가 가지고 있다.
    
    var body: some View {
        SettingViewWrapper {
            SettingGridView(title: "내 정보") {
                ZStack {
                    Rectangle().fill(Color.red)
                    VStack {
                        Divider().padding(0)
                        ForEach(devices, id: \.udid) { device in
                            SettingRow(device: device)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            SettingGridView(title: "백업 관리") {
                ZStack {
                    Rectangle().fill(Color.red)
                    VStack {
                        Divider().padding(0)
                        ForEach(devices, id: \.udid) { device in
                            SettingRow(device: device)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            SettingGridView(title: "기기 관리") {
                ZStack {
                    Rectangle().fill(Color.red)
                    VStack {
                        Divider().padding(0)
                        ForEach(devices, id: \.udid) { device in
                            SettingRow(device: device)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
    }
}

struct SettingRow: View {
    var device: Device
    
    var body: some View {
        VStack {
            HStack {
                Text("\(device.name ?? "dd")")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .frame(height: 40)
            Divider()
                .padding(0)
        }
    }
}

struct SettingPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
    
}

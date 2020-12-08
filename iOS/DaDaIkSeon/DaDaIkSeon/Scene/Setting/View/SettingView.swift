//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import SwiftUI

// Toggle Observable
// Transition Observable 만들기

class SettingTransition: ObservableObject {
    // MARK: 화면 전환 또는 토글? - 새로운 화면에서 설정 해야 하는 것들
    // 생체 인식, 핀넘버 사용 화면 전환
    @State var securitySetting: Bool = false
    // 이메일 변경 화면 전환
    @State var emailSetting: Bool = false
    // 백업 On/off 토글
    @Published var backupToggle: Bool = false
    // 멀티 디바이스 On/off 토글
    @Published var multiDeviceToggle: Bool = false
    // 비밀 번호 변경하기 화면 전환
    @Published var passwordSetting: Bool = false
    // 디바이스 정보 변경 화면 전환
    @Published var deviceSetting: Bool = false
}

struct SettingView: View {
    
    // MARK: 뷰모델
    @ObservedObject var viewModel = SettingViewModel()
    
    @ObservedObject var trsnsion = SettingTransition()
    
    @State var passwordSetting: Bool = false
    
    @State var deviceSetting: Bool = false
    
    // MARK: 진짜 상태값 State
    @State var backupMode: Bool = false
    @State var multiDeviceMode: Bool = false
    
    // 서비스가 갖도록
    @State var user = DDISUser.dummy()
        
    var body: some View {
        SettingViewWrapper {
            
            // MARK: 내정보 관리
            
            SettingGridView(title: "내 정보", titleColor: .white) {
                VStack {
                    Divider().padding(0)
                    SettingRow(title: "✉️ " + (user.email ?? "")) {
                        Image.chevron
                    }
                    .onTapGesture {
                        print("이메일 변경")
                    }
                    SettingRow(title: "보안 강화하기") {
                        Image.chevron
                    }
                    .onTapGesture {
                        print("보안 강화하기")
                    }  
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 10)
                
            // MARK: 백업 관리
            
            SettingGridView(title: "백업 관리", titleColor: .white) {
                VStack {
                    Divider().padding(0)
                    SettingRow(title: "백업 할래?") {
                        Toggle(isOn: $trsnsion.backupToggle, label: {
                            Text("")
                        })
                        .onChange(of: trsnsion.backupToggle, perform: { _ in
                            print("백업할래")
                        })
                    }
                    SettingRow(title: "비밀번호 변경하기?") {
                        Image.chevron
                    }
                    .onTapGesture {
                        print("비밀번호 변경하기")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 10)
            
            // MARK: 기기 관리
            
            SettingGridView(title: "기기 관리", titleColor: .white) {
                VStack {
                    Divider().padding(0)
                    SettingRow(title: "다른데서도 쓸거야?") {
                        Toggle(isOn: $trsnsion.multiDeviceToggle, label: {
                            Text("")
                        })
                        .onChange(of: trsnsion.multiDeviceToggle, perform: { _ in
                            print("다른데서도 쓸거야?")
                        })
                    }
                    ForEach(user.device!, id: \.udid) { device in
                        SettingRow(title: device.name ?? "") {
                            Image.chevron
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 10)
            
            Spacer()
        }
        
    }
}

struct SettingRow<Item: View>: View {
    
    var title: String
    var item: Item
    
    init(title: String, @ViewBuilder item: @escaping () -> Item ) {
        self.title = title
        self.item = item()
    }
    
    var body: some View {
        VStack {
            HStack {
                
                Text("\(title)")
                
                Spacer()
                
                item
                
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

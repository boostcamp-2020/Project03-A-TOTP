//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import SwiftUI

struct SettingState {
    //var user: DDISUser // 로드해서 받아온다.
    var service: SettingServicable
}

enum SettingInput {
    // 완료 버튼
    
    // 리프레시 버튼
    case refresh
    // 누르면 정보 다 불러옴. - 라스트 데이트 검사 해서 최신 데이터로 업데이트
    
    // 내정보
    // 이메일 - 터치하면 수정 가능 해야 함. - 수정 후 서버 요청
    
    // 백업관리
    // 백업할래? - 토글 - 서버 요청 - on 하면 불러오기
    case backupToggle
    // 백업 비밀번호 변경 - '화면'필요
            // - 변경 후 요청
    
    // 기기관리
    // 멀티디바이스 - 토글
    case multiDeviceToggle
    // 리스트 셀 터치 - 변경 가능해야함 - '화면'필요
    
    // 삭제는 어떻게 하지?
}

struct SettingView: View {
    
    // MARK: 뷰모델
    @ObservedObject var viewModel = SettingViewModel()
    
    @ObservedObject var settingTrsnsion = SettingTransition()
    
    // 서비스가 갖도록
    @State var user = DDISUser.dummy()
        
    var body: some View {
        SettingViewWrapper {
            
            // MARK: 내정보 관리
            
            SettingGridView(title: "내 정보", titleColor: .white) {
                VStack {
                    Divider().padding(0)
                    NavigationLink(
                        destination: NavigationLazyView(TestView()),
                        label: {
                            SettingRow(title: "✉️ " + (user.email ?? "")) { Image.chevron }
                        })
                        .foregroundColor(.black)
//                    NavigationLink(
//                        destination: NavigationLazyView(TestView()),
//                        label: {
//                            SettingRow(title: "보안 강화하기") { Image.chevron }
//                        })
//                        .foregroundColor(.black)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 10)
                
            // MARK: 백업 관리
            
            SettingGridView(title: "백업 관리", titleColor: .white) {
                VStack {
                    Divider().padding(0)
                    SettingRow(title: "백업 할래?") {
                        Toggle(isOn: $settingTrsnsion.backupToggle, label: {
                            Text("")
                        })
                        .onChange(of: settingTrsnsion.backupToggle, perform: { _ in
                            print("백업할래") // 뷰모델 트리거
                        })
                    }
                    NavigationLink(
                        destination: NavigationLazyView(TestView()),
                        label: {
                            SettingRow(title: "비밀번호 변경하기?") { Image.chevron }
                        })
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 10)
            
            // MARK: 기기 관리
            
            SettingGridView(title: "기기 관리", titleColor: .white) {
                VStack {
                    Divider().padding(0)
                    SettingRow(title: "다른데서도 쓸거야?") {
                        Toggle(isOn: $settingTrsnsion.multiDeviceToggle, label: {Text("")})
                        .onChange(of: settingTrsnsion.multiDeviceToggle, perform: { _ in
                            print("다른데서도 쓸거야?") // 뷰모델 트리거
                        })
                    }
                    ForEach(user.device!, id: \.udid) { device in
                        NavigationLink(
                            destination: NavigationLazyView(TestView()),
                            label: {
                                SettingRow(title: device.name ?? "") { Image.chevron }
                            })
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 10)
            
            Spacer()
        }
        
    }
}

struct TestView: View {
    var body: some View {
        Text("")
    }
}

struct SettingPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
    
}

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
    
    @ObservedObject var settingTrsnsion = SettingTransition()
    
    // 서비스가 갖도록
    @State var user = DDISUser.dummy()
    
    func isLastDivice(udid: String?) -> Bool {
        guard let udid = udid else { return true }
        guard let device = viewModel.state.devices.last else {
            return true
        }
        return device.udid == udid
    }
    
    var body: some View {
        SettingViewWrapper(action: {
            viewModel.trigger(.refresh)
        }, content: {
            Spacer().frame(height: 10)
            
            // MARK: 내정보 관리
            SettingGridView(title: "내 정보", titleColor: .white) {
                NavigationLink(
                    destination: NavigationLazyView(TestView()),
                    label: {
                        SettingRow(title: "✉️ " + (user.email ?? ""),
                                   isLast: true) { Image.chevron }
                    })
                    .foregroundColor(.black)
                //                    NavigationLink(
                //                        destination: NavigationLazyView(TestView()),
                //                        label: {
                //                            SettingRow(title: "보안 강화하기") { Image.chevron }
                //                        })
                //                        .foregroundColor(.black)
                //                }
                //                .padding(.horizontal)
            }
            .padding(.horizontal, 10)
            
            // MARK: 백업 관리
            
            SettingGridView(title: "백업 관리", titleColor: .white) {
                SettingRow(title: "백업 할래?",
                           isLast: false) {
                    Toggle(isOn: $settingTrsnsion.backupToggle, label: {
                        Text("")
                    })
                    .onChange(of: settingTrsnsion.backupToggle, perform: { _ in
                        viewModel.trigger(.backupToggle)
                    })
                }
                NavigationLink(
                    destination: NavigationLazyView(TestView()),
                    label: {
                        SettingRow(
                            title: "비밀번호 변경하기?",
                            isLast: true) { Image.chevron }
                    })
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 10)
            
            // MARK: 기기 관리
            
            SettingGridView(title: "기기 관리", titleColor: .white) {
                SettingRow(title: "다른데서도 쓸거야?", isLast: false) {
                    Toggle(isOn: $settingTrsnsion.multiDeviceToggle, label: {Text("")})
                        .onChange(of: settingTrsnsion.multiDeviceToggle, perform: { _ in
                            viewModel.trigger(.multiDeviceToggle)
                        })
                }
                ForEach(user.device!, id: \.udid) { device in
                    NavigationLink(
                        destination: NavigationLazyView(TestView()),
                        label: {
                            SettingRow(
                                title: device.name ?? "",
                                isLast: isLastDivice(udid: device.udid)) {
                                Image.chevron
                            }})
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            Spacer()
        })
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
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

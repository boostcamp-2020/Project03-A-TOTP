//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: ViewModel
    @ObservedObject var viewModel = SettingViewModel()
    
    // MARK: Property
    @ObservedObject var settingTrsnsion = SettingTransition()
    
    var body: some View {
        SettingViewWrapper(action: {
            viewModel.trigger(.refresh)
        }, content: {
            Spacer().frame(height: 10)
            
            // MARK: 내정보 관리
            SettingGridView(title: "내 정보", titleColor: .white) {
                
                SettingRow(title: "✉️ " + (viewModel.state.email),
                           isLast: viewModel.state.emailEditMode ? false : true) {
                    viewModel.state.emailEditMode ?
                        Image.chevronDown : Image.chevronRight
                }
                .onTapGesture {
                    withAnimation { // 애니메이션 좀 더 생각해보기
                        settingTrsnsion.emailTextField = ""
                        viewModel.trigger(.editEmailMode)
                    }
                }
                
                if viewModel.state.emailEditMode {
                    HStack {
                        TextField(viewModel.state.email, text: $settingTrsnsion.emailTextField)
                            .padding(.leading)
                        Divider()
                        Button(action: {
                            viewModel.trigger(.editEmail(settingTrsnsion.emailTextField))
                        }, label: {
                            Text("변경하기").foregroundColor(Color.navy1)
                        })
                    }
                    Text( viewModel.state.emailValidation ? "" : "이메일 형식이 잘못되었습니다." )
                    Divider().opacity(0)
                }
                
//                SettingRow(title: "보안 강화하기") { Image.chevron }
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
                            isLast: true) { Image.chevronRight }
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
                ForEach(viewModel.state.devices, id: \.udid) { device in
                    NavigationLink(
                        destination: NavigationLazyView(TestView()),
                        label: {
                            SettingRow(
                                title: device.name ?? "",
                                isLast: isLastDivice(udid: device.udid)) {
                                Image.chevronRight
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

extension SettingView {
    
    func isLastDivice(udid: String?) -> Bool {
        guard let udid = udid else { return true }
        guard let device = viewModel.state.devices.last else {
            return true
        }
        return device.udid == udid
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

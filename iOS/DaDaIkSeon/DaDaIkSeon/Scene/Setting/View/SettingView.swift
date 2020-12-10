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
    @ObservedObject var stateManager = SettingTransition()
    
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
                        stateManager.newEmail = ""
                        viewModel.trigger(.editEmailMode)
                    }
                }
                
                if viewModel.state.emailEditMode {
                    HStack {
                        TextField(viewModel.state.email, text: $stateManager.newEmail)
                            .padding(.leading)
                        Divider()
                        Button(action: {
                            viewModel.trigger(.editEmail(stateManager.newEmail))
                        }, label: {
                            Text("변경하기").foregroundColor(Color.navy1)
                        })
                    }
                    Text( viewModel.state.emailValidation ? "" : "이메일 형식이 잘못되었습니다." )
                    Divider().opacity(0)
                }
                
                // MARK: 보안강화하기
                
                SettingRow(title: "보안 강화하기",
                           isLast: false) {
                    viewModel.state.authEditMode ? Image.chevronDown : Image.chevronRight
                }
                .onTapGesture {
                    withAnimation {
                        viewModel.trigger(.editAuthMode)
                    }
                }
                
                if viewModel.state.authEditMode {
                    
                    // 토글 on/off의 결과
                    // on: 핀 넘버 설정 화면으로 넘어간다.
                    //        -> 키체인에 해당 핀 넘버 저장(설정 뷰모델 - 클로저로 넘겨줌) 후 다시 돌아오기
                    // off: 키체인에서 핀 넘버 삭제하기(설정 뷰모델)
                    
                    //
                    
                    Toggle(isOn: $stateManager.faceIDToggle, label: {
                        Text("FaceID/TouchID")
                    })
                    .onChange(of: stateManager.faceIDToggle, perform: { _ in
                        if stateManager.faceIDToggle {  // true로 설정
                            // 핀넘버 화면으로 이동 - 이 화면에서 핀넘버 두 번 확인하고 일치하면 저장
                            // 여기에 뷰모델에 있는 키체인 등록 트리거를 호출하도록함. 클로저로 핀넘버 받아옴.
                            stateManager.pinCodeSetting = true
                        } else {                        // false로 설정
                            viewModel.trigger(.liberateDaDaIkSeon)
                        }
                    })
                    Spacer()
                    Divider().opacity(0)
                    NavigationLink(destination:
                                    PinCodeView(mode: .setup, completion: { pincode in
                                        viewModel.trigger(.protectDaDaIkSeon(pincode))
                                    }),
                                   isActive: $stateManager.pinCodeSetting, label: { Text("") })
                }
            }
            .padding(.horizontal, 10)
            
            // MARK: 백업 관리
            
            SettingGridView(title: "백업 관리", titleColor: .white) {
                SettingRow(title: "백업 사용하기",
                           isLast: false) {
                    Toggle(isOn: $stateManager.backupToggle, label: {
                        Text("")
                    })
                    .onChange(of: stateManager.backupToggle, perform: { _ in
                        viewModel.trigger(.backupToggle)
                    })
                }
                
                SettingRow(
                    title: "백업 비밀번호 변경하기", isLast: true) {
                    viewModel.state.backupPasswordEditMode ?
                        Image.chevronDown : Image.chevronRight
                }
                .onTapGesture {
                    withAnimation {
                        stateManager.newPassword = ""
                        stateManager.newPasswordCheck = ""
                        viewModel.trigger(.editBackupPasswordMode)
                    }
                }
                
                // enum 값으로 비밀번호 에러 관리
                
                if viewModel.state.backupPasswordEditMode {
                    HStack {
                        TextField("새 비밀번호를 입력해주세요.", text: $stateManager.newPassword)
                            .padding(.leading)
                        Divider()
                        Button(action: {
                            viewModel.trigger(.editBackupPassword(stateManager.newPassword))
                        }, label: {
                            Text("확인").foregroundColor(Color.navy1)
                        })
                    }
                    Text( "\(viewModel.state.editErrorMessage.rawValue)" )
                    Divider().opacity(0)
                } else if viewModel.state.backupPasswordEditCheckMode {
                    HStack {
                        TextField("비밀번호를 한 번 더 입력해주세요.", text: $stateManager.newPasswordCheck)
                            .padding(.leading)
                        Divider()
                        Button(action: {
                            viewModel.trigger(.checkPassword(
                                                stateManager.newPassword,
                                                stateManager.newPasswordCheck))
                        }, label: {
                            Text("확인").foregroundColor(Color.navy1)
                        })
                    }
                    Text( "\(viewModel.state.editErrorMessage.rawValue)" )
                    Divider().opacity(0)
                }
                
            }
            .padding(.horizontal, 10)
            
            // MARK: 기기 관리
            
            SettingGridView(title: "기기 관리", titleColor: .white) {
                SettingRow(title: "여러 기기 사용하기", isLast: false) {
                    Toggle(isOn: $stateManager.multiDeviceToggle, label: {Text("")})
                        .onChange(of: stateManager.multiDeviceToggle, perform: { _ in
                            viewModel.trigger(.multiDeviceToggle)
                        })
                }
                ForEach(viewModel.state.devices, id: \.udid) { device in
                    SettingRow(
                        title: device.name ?? "",
                        isLast: isLastDivice(udid: device.udid)
                            && !isSelectedDevice(deviceID: device.udid)
                    ) {
                        isSelectedDevice(deviceID: device.udid) ?
                            Image.chevronDown : Image.chevronRight
                    }
                    .onTapGesture {
                        withAnimation {
                            stateManager.newDeviceName = ""
                            viewModel.trigger(.deviceInfoMode(device.udid ?? ""))
                        }
                    }
                    
                    if isSelectedDevice(deviceID: device.udid) {
                        
                        HStack {
                            TextField(device.name ?? "", text: $stateManager.newDeviceName)
                            Divider()
                            Button(action: {
                                viewModel.trigger(.deleteDevice(device.udid ?? ""))
                            }, label: {
                                Text("삭제").foregroundColor(Color.pink)
                            })
                            Button(action: {
                                var newDevice = device
                                newDevice.name = stateManager.newDeviceName
                                viewModel.trigger(.editDevice(newDevice))
                            }, label: {
                                Text("확인").foregroundColor(Color.navy1)
                            })
                        }
                        
                        Text("\(viewModel.state.editErrorMessage.rawValue)")
                        
                        Divider()
                        HStack {
                            Text("디바이스 아이디:")
                            Spacer()
                            Text("\(device.udid ?? "")")
                        }
                        HStack {
                            Text("모델 이름:")
                            Spacer()
                            Text("\(device.modelName ?? "")")
                        }
                        Divider().padding(0)
                    }
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
    
    func isSelectedDevice(deviceID: String?) -> Bool {
        viewModel.state.deviceInfoMode
            && viewModel.state.deviceID == deviceID
    }
    
}

struct SettingPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
    
}

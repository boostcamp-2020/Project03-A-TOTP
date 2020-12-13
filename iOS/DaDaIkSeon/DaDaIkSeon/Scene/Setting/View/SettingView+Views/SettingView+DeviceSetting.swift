//
//  SettingView+DeviceSetting.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import SwiftUI

extension SettingView {
    
    var deviceSettingView: some View {
        
        SettingGridView(title: "기기 관리", titleColor: .white) {
            SettingRow(title: "여러 기기 사용하기", isLast: false) {
                SettingToggleView(isOn: $viewModel.state.deviceToggle)
                    .onTapGesture {
                        viewModel.trigger(.settingMultiDevice(.multiDeviceToggle))
                    }
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
                        stateManager.newDeviceName.text = ""
                        viewModel.trigger(.settingMultiDevice(.deviceInfoMode(device.udid ?? "")))
                    }
                }
                
                if isSelectedDevice(deviceID: device.udid) {
                    
                    HStack {
                        
                        TextField(device.name ?? "", text: $stateManager.newDeviceName.text)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                        
                        Divider()
                        
                        Button(action: {
                            stateManager.deviceAlert = true
                        }, label: {
                            Text("삭제").foregroundColor(Color.pink)
                        })
                        Divider()
                        Button(action: {
                            var newDevice = device
                            newDevice.name = stateManager.newDeviceName.text
                            viewModel.trigger(.settingMultiDevice(.editDevice(newDevice)))
                        }, label: {
                            Text("확인").foregroundColor(Color.navy1)
                        })
                        Divider()
                        
                    }
                    
                    SettingErrorMessageView(viewModel.state.deviceErrorMessage.rawValue)
                    
                    Divider()
                    
                    HStack {
                        Text("모델 이름").fontWeight(.bold)
                        Divider()
                        Spacer()
                        Text("\(device.modelName ?? "")")
                    }
                    Divider().padding(0)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .alert(isPresented: $stateManager.deviceAlert, content: {
            Alert(
                title: Text("디바이스 삭제"),
                message: Text("삭제한 디바이스를 다시 사용하고 싶으시다면 앱을 다시 설치하여야 합니다."),
                primaryButton: .destructive(
                    Text("삭제"), action: {
                        withAnimation {
                            viewModel.trigger(.settingMultiDevice(.deleteDevice))
                        }}),
                secondaryButton: .cancel(Text("취소")))
        })
    }

    func isLastDivice(udid: String?) -> Bool {
        guard let udid = udid else { return true }
        guard let device = viewModel.state.devices.last else {
            return true
        }
        return device.udid == udid
    }
    
    func isSelectedDevice(deviceID: String?) -> Bool {
        viewModel.state.selectedDeviceID == deviceID
    }
    
}

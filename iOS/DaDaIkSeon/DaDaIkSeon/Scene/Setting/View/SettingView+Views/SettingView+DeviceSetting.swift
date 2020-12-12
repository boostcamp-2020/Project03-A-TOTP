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
        
    }
    
    
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

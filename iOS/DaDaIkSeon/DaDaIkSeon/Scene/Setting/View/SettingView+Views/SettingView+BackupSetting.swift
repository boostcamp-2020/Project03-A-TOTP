//
//  SettingView+BackupSetting.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import SwiftUI

extension SettingView {
    
    var backupView: some View {
        
        SettingGridView(title: "백업 관리", titleColor: .white) {
            SettingRow(title: "백업 사용하기",
                       isLast: false) {
                SettingToggleView(isOn: $viewModel.state.backupToggle)
                    .onTapGesture {
                        
                        viewModel.trigger(.backupToggle)
                        
                    }
            }
            
            SettingRow(
                title: "백업 비밀번호 변경하기", isLast: true) {
                viewModel.state.backupPasswordEditMode ?
                    Image.chevronDown : Image.chevronRight
            }
            .onTapGesture {
                
                // toggle on/off는 네트워크에 전달되어야 함.
                
                // 바로 변경하는 게 아님.
                // 키체인 read로 비밀번호가 있는지 확인
                // 있으면 바로 네트워크 통신
                // 없으면 비밀 번호 설정하라고 editview 열어줌 - 설정 후 키체인 저장
                // 그리고 나서 네트워크 통신
                
                // 네트워크 통신이 완료 되어야 비로소 on으로 설정 완료
                // 마찬가지로 off도 네트워크 통신이 되어야 on으로 설정 완료
                
                withAnimation {
                    stateManager.newPassword = ""
                    stateManager.newPasswordCheck = ""
                    viewModel.trigger(.editBackupPasswordMode)
                }
            }
            
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
    }
}

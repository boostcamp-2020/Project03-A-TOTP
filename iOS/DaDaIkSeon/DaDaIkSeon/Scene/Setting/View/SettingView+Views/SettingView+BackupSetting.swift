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
    }
}



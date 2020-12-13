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
                        viewModel.trigger(.settingBackup(.backupToggle))
                    }
            }
            
            SettingRow(
                title: "백업 비밀번호 변경하기", isLast: true) {
                viewModel.state.backupPasswordEditMode ?
                    Image.chevronDown : Image.chevronRight
            }
            .onTapGesture {
                withAnimation {
                    stateManager.newPassword.text = ""
                    stateManager.newPasswordCheck.text = ""
                    viewModel.trigger(.settingBackup(.editBackupPasswordMode))
                }
            }
            
            if viewModel.state.backupPasswordEditMode {
                
                HStack {
                    TextField("새 비밀번호를 입력해주세요.", text: $stateManager.newPassword.text)
                        .padding(.leading)
                    Divider()
                    Button(action: {
                        viewModel.trigger(
                            .settingBackup(.editBackupPassword(stateManager.newPassword.text)))
                    }, label: {
                        Text("확인").foregroundColor(Color.navy1)
                    })
                }
                
                SettingErrorMessageView(viewModel.state.passwordErrorMessage.rawValue)
                
                Divider().opacity(0)
                
            } else if viewModel.state.backupPasswordEditCheckMode {
                HStack {
                    TextField("비밀번호를 한 번 더 입력해주세요.", text: $stateManager.newPasswordCheck.text)
                        .padding(.leading)
                    Divider()
                    Button(action: {
                        viewModel.trigger(.settingBackup(.checkPassword(
                                                            stateManager.newPassword.text,
                                                            stateManager.newPasswordCheck.text)))
                    }, label: {
                        Text("확인").foregroundColor(Color.navy1)
                    })
                }
                
                SettingErrorMessageView(viewModel.state.passwordErrorMessage.rawValue)
                
                Divider().opacity(0)
            }
            
        }
        .padding(.horizontal, 10)
    }
}

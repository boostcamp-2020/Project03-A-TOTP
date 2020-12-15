//
//  SettingView+MyInfoSetting.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import SwiftUI

extension SettingView {
    var myInfoView: some View {
        SettingGridView(title: "내 정보", titleColor: .white) {
            
            #if DEBUG
            SettingRow(title: "✉️ " + (viewModel.state.email),
                       isLast: false) {
                viewModel.state.emailEditMode ?
                    Image.chevronDown : Image.chevronRight
            }
            .onTapGesture {
                withAnimation {
                    stateManager.newEmail.text = ""
                    viewModel.trigger(.settingEmail(.editEmailMode))
                }
            }
            
            if viewModel.state.emailEditMode {
                HStack {
                    TextField(viewModel.state.email, text: $stateManager.newEmail.text)
                        .padding(.leading)
                    Divider()
                    Button(action: {
                        viewModel.trigger(.settingEmail(.editEmail(stateManager.newEmail.text)))
                    }, label: {
                        Text("변경하기").foregroundColor(Color.navy1)
                    })
                }
                
                SettingErrorMessageView(viewModel.state.emailValidation ? "" : "이메일 형식이 잘못되었습니다.")
                
                Divider().opacity(0)
            }
            #endif
            
            // MARK: 보안강화하기
            
            SettingRow(title: "보안 강화하기",
                       isLast: viewModel.state.authEditMode ? false:true) {
                viewModel.state.authEditMode ? Image.chevronDown : Image.chevronRight
            }
            .onTapGesture {
                withAnimation {
                    viewModel.trigger(.settingAuthMode(.editAuthMode))
                }
            }
            if viewModel.state.authEditMode {
                HStack {
                    Text("FaceID/TouchID")
                    Spacer()
                    Button(action: {
                        stateManager.pinCodeSetting = true
                    }, label: {
                        SettingToggleView(isOn: $stateManager.faceIDToggle)
                    })
                }
                Divider().opacity(0)
            }
        }
        .padding(.horizontal, 10)
    }
}

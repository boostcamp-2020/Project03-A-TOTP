//
//  BackupPasswordView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/15.
//

import SwiftUI

struct BackupPasswordView: View {
    
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
    @StateObject var viewModel: AnyViewModel<BackupPasswordState, BackupPasswordInput>
    @ObservedObject var passwordEntry = Entry(limit: 15)
    @ObservedObject var passwordCheckEntry = Entry(limit: 15)
    
    init(viewModel: AnyViewModel<BackupPasswordState, BackupPasswordInput>) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image.logo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            Spacer()
            
            mainMessageText
            
            Spacer()
            
            VStack(alignment: .trailing) {
                errorMessageText
                passwordTextField
                viewModel.state.isMultiUser ? nil : passwordCheckTextField
            }
            
            Spacer()
            
            Button(action: {
                viewModel.trigger(.next(passwordEntry.text))
            }, label: {
                HStack {
                    Spacer()
                    Text(viewModel.state.isMultiUser ? "백업 불러오기" : "백업 활성화")
                    Spacer()
                }
            })
            .foregroundColor(.white)
            .frame(width: 120)
            .padding(.vertical, 10)
            .background(LinearGradient.navy)
            .cornerRadius(15)
            .disabled(!viewModel.state.enable)
            
            Spacer()
        }
        .padding(.horizontal, 40)
        .onChange(of: viewModel.state.next, perform: { value in
            if value { mode.wrappedValue.dismiss() }
        })
    }
}

extension BackupPasswordView {
    
    var mainMessageText: some View {
        Text(viewModel.state.isMultiUser
                ? "토큰을 백업할 때 저장했던\n비밀번호를 입력해주세요"
                : "토큰을 백업할\n 비밀번호를 설정해주세요")
            .multilineTextAlignment(.center)
    }
    
    var errorMessageText: some View {
        Text(viewModel.state.errorMessage.rawValue)
            .font(.system(size: 11))
            .foregroundColor(.gray)
            .padding(.trailing, 8)
    }
    
    var passwordTextField: some View {
        TextField("15자이내 비밀번호 입력", text: $passwordEntry.text)
            .modifier(TextFieldModifier())
            .onChange(of: passwordEntry.text) { text in
                viewModel.trigger(.inputPassword(text))
            }
    }
    
    var passwordCheckTextField: some View {
        TextField("비밀번호 확인", text: $passwordCheckEntry.text)
            .modifier(TextFieldModifier())
            .onChange(of: passwordCheckEntry.text) { text in
                viewModel.trigger(.inputPasswordCheck(passwordEntry.text,
                                                      text))
            }
    }
    
}

// MARK: ViewModifier

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding(8)
            .background(Color(.white))
            .cornerRadius(10)
            .multilineTextAlignment(.center)
            .shadow(color: Color.black.opacity(0.1),
                    radius: 5,
                    x: 0.0,
                    y: 0.3)
    }
}

struct BackupPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        BackupPasswordView(viewModel: AnyViewModel(BackupPasswordViewModel(
                                service: TokenService(StorageManager()))))
    }
}

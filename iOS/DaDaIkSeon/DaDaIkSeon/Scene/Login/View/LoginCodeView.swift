//
//  LoginCodeView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import SwiftUI

struct LoginCodeView: View {
    
    // MARK: ViewModel
    
    @ObservedObject var viewModel: AnyViewModel<LoginState, LoginInput>
    @State private var codeText = ""
    @State private var isAlert = false
    let completion: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    backToEmailView()
                } label: {
                    Image.back
                        .resizable()
                        .frame(width: 33, height: 33)
                        .foregroundColor(Color.navy2)
                }
                Spacer()
            }
            
            Spacer()
            
            Text(viewModel.state.checkCodeText)
                .font(.system(size: 11))
                .foregroundColor(.gray)
                .padding(.trailing, 8)
            
            TextField("6자리 코드 입력", text: $codeText)
                .padding(8)
                .background(Color(.white))
                .cornerRadius(10)
                .multilineTextAlignment(.center)
                .shadow(color: Color.black.opacity(0.1),
                        radius: 5,
                        x: 0.0,
                        y: 0.3)
                .onChange(of: codeText) { _ in
                    checkTextChange()
                }
            
            Spacer()
            
            Button(action: {
                authButtonDidTap()
            }, label: {
                Text("인증")
                    .foregroundColor(.white)
            })
            .alert(isPresented: $isAlert) {
                Alert(title: Text("코드가 일치하지 않습니다"),
                      message: Text("입력하신 코드를 확인해주세요"),
                      dismissButton: .default(Text("네")))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.navy2)
            .cornerRadius(10)
        }
        .padding(.all, 30)
    }
    
}

private extension LoginCodeView {
    
    func backToEmailView() {
        withAnimation {
            viewModel.trigger(.backButton)
        }
    }
    
    func checkTextChange() {
        viewModel.trigger(.checkCode(codeText))
    }
    
    func authButtonDidTap() {
        guard let myDevice = DDISUserCache.get()?.device else { return }
        viewModel.trigger(.authButton(codeText,
                                      device: myDevice,
                                      completion: { token in
            if token != nil {
                isAlert = false
                completion()
            } else {
                isAlert = true
            }
        }))
    }
    
}

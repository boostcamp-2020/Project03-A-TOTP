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
        let device = Device(name: UIDevice.current.name,
                            udid: UIDevice.current.identifierForVendor?.uuidString,
                            modelName: UIDevice.current.model,
                            backup: false,
                            lastUpdate: nil)
        viewModel.trigger(.authButton(codeText,
                                      device: device,
                                      completion: {
            completion()
        }))
    }
    
}

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
    
    var body: some View {
        VStack {
            Button {
                backToEmailView()
            } label: {
                Image.back
                    .resizable()
                    .frame(width: 33, height: 33)
                    .foregroundColor(Color.navy2)
                    .padding()
            }
        }
    }
    
}

private extension LoginCodeView {
    
    func backToEmailView() {
        withAnimation {
            viewModel.trigger(.backButton)
        }
    }
    
}

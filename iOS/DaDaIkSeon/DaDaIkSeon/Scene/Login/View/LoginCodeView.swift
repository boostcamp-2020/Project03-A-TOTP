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
                Text("뒤로가.")
            }

            Text("hi")
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

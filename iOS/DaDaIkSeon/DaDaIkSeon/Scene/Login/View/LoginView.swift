//
//  LoginView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/06.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: AnyViewModel<LoginState, LoginInput>
    
    init(service: LoginServiceable) {
        viewModel = AnyViewModel(LoginViewModel(service: service))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let geometryWidth = geometry.size.width
            let geometryHeight = geometry.size.height
            
            ZStack {
                Image("background")
                    .resizable()
                    .frame(width: geometryWidth)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if viewModel.state.isEmailView {
                        LoginEmailView(viewModel: viewModel,
                                       geometryWidth: geometryWidth)
                    } else {
                        LoginCodeView(viewModel: viewModel)
                    }
                    Spacer()
                }
                .frame(width: geometryWidth * 0.83,
                       height: geometryHeight * 0.855,
                       alignment: .center)
                .background(Color.white)
                .cornerRadius(45)
                .shadow(color: Color.black.opacity(0.1),
                        radius: 10,
                        x: 0.0,
                        y: 0.3)
            }
        }
    }
}

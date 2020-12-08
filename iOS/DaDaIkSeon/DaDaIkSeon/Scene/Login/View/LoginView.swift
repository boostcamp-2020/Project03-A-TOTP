//
//  LoginView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/06.
//

import SwiftUI

struct LoginView: View {
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
                    Rectangle()
                        .frame(width: geometryWidth * 0.83,
                               height: geometryHeight * 0.855,
                               alignment: .center)
                        .foregroundColor(.white)
                        .cornerRadius(45)
                        .shadow(color: Color.black.opacity(0.1),
                                radius: 10,
                                x: 0.0,
                                y: 0.3)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

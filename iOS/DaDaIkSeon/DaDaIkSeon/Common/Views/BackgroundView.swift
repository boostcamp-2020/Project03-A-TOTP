//
//  BackgroundView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            let height = reader.size.height
            Image.logo.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width / 3)
                .position(x: width / 2, y: height / 2)
        }
        .background(Color.darkNavy)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
}

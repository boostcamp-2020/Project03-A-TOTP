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
            Image.DDISBackground
                .resizable()
                .frame(width: width)
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
            Image.logo.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width / 2)
                .position(x: width / 2, y: height / 2)
        }
    }
}

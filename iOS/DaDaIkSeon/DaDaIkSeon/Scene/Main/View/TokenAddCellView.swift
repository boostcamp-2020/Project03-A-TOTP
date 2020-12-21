//
//  TokenAddCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/27.
//

import SwiftUI

struct TokenAddCellView: View {
    
    // MARK: Body
    
    @State var showSheetView = false
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image.plus
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(Color(.systemGray2))
                
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, 12)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5.0]))
                .foregroundColor(Color(.systemGray2))
        )
    }
}

struct TokenAddCellView_Previews: PreviewProvider {
    static var previews: some View {
        TokenAddCellView()
    }
}

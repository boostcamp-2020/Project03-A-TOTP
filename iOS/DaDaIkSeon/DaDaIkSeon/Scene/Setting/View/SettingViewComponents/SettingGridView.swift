//
//  SettingGridView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import SwiftUI

struct SettingGridView<Rows: View>: View {
    
    var rows: Rows
    var title: String
    var titleColor: Color
    var columns = [GridItem(.flexible())]
    
    init(title: String, titleColor: Color, @ViewBuilder rows: @escaping () -> Rows) {
        self.title = title
        self.rows = rows()
        self.titleColor = titleColor
    }
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 0
        ) {
            Section(header: HStack {
                Text(title)
                    .foregroundColor(Color(UIColor.systemGray))
                Spacer()
            }.padding(.bottom, 5)
            ) {
                ZStack {
                    backGround
                    VStack {
                        Divider().padding(0)
                        rows
                    }
                    .padding(.horizontal)
                }
                
            }
        }
    }
    
    var backGround: some View {
        Rectangle().fill(titleColor)
            .cornerRadius(15)
    }
}

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
    var columns = [GridItem(.flexible())]
    
    init(title: String, @ViewBuilder rows: @escaping () -> Rows) {
        self.title = title
        self.rows = rows()
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
            }.padding()
            ) {
                rows
            }
        }
    }
}

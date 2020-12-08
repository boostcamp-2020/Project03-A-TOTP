//
//  SettingRow.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import SwiftUI

struct SettingRow<Item: View>: View {
    
    var title: String
    var item: Item
    var isLast: Bool
    
    init(title: String, isLast: Bool, @ViewBuilder item: @escaping () -> Item ) {
        self.title = title
        self.item = item()
        self.isLast = isLast
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(title)")
                Spacer()
                item
                
            }
            .frame(height: 40)
            Divider()
                .padding(0)
                .opacity(isLast ? 0.0 : 1.0)
        }
    }
}

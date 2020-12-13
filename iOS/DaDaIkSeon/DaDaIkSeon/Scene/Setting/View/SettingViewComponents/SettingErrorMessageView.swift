//
//  SettingErrorMessageView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import SwiftUI

struct SettingErrorMessageView: View {
    
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 10))
            .foregroundColor(Color.pink2)
    }
}

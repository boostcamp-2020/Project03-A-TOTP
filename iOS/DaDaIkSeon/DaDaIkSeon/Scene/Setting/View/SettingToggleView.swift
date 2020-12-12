//
//  SettingToggleView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/12.
//

import SwiftUI

// 조건 검사하고 수동으로 state를 바꿔야 변경되는 토글
struct SettingToggleView: View {
    
    @Binding var isOn: Bool
    
    init(isOn: Binding<Bool>) {
        _isOn = isOn
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill( isOn ? Color.green
                        :Color(UIColor.systemGray4)
                )
                .frame(width: 50, height: 30)
            Circle().fill(Color.white)
                .frame(width: 25)
                .offset(x: isOn ? 10.0:-10.0, y: 0.0)
        }
    }
}

struct SettingTogglePreview: PreviewProvider {
    static var previews: some View {
        VStack {
            SettingToggleView(isOn: .constant(true))
            SettingToggleView(isOn: .constant(false))
        }
    }
}

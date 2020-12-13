//
//  SettingViewNavigationWrapper.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import SwiftUI

struct SettingViewWrapper<Content: View>: View {
    
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
    
    private var destinationView: Content
    private var action: (() -> Void)?
    
    init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.destinationView = content()
        self.action = action
    }
    
    var body : some View {
        ScrollView {
            destinationView
                .navigationBarHidden(false)
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading: Button(action: {
                        mode.wrappedValue.dismiss()
                    }, label: {
                        Text("완료").foregroundColor(.black)
                    }),
                    trailing: Button(action: {
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.black)
                            .onTapGesture {
                                action?()
                            }
                    })
                )
        }
    }
}

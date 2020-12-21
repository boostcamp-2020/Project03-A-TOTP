//
//  SettingViewNavigationWrapper.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import SwiftUI

struct SettingViewWrapper<Content: View>: View {
    
    private var destinationView: Content
    private var action: (() -> Void)?
    @ObservedObject var linkManager: MainLinkManager
    
    init(linkManager: ObservedObject<MainLinkManager>,
         action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.destinationView = content()
        self.action = action
        _linkManager = linkManager
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
                        linkManager.change(.main)
                    }, label: {
                        Text("완료").foregroundColor(.button)
                    }),
                    trailing: Button(action: {
                    }, label: {
                        #if DEBUG
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.black)
                            .onTapGesture {
                                action?()
                            }
                        #endif
                    })
                )
            
        }
        .keyboardManagment()
    }
}

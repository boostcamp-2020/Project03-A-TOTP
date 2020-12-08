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
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.destinationView = content()
    }
    
    var body : some View {
        VStack {
            ScrollView {
                destinationView
                    .background(Color(UIColor.systemGray6))
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
                                    print("새로고침")
                                }
                        })
                    )
            }
        }
    }
}

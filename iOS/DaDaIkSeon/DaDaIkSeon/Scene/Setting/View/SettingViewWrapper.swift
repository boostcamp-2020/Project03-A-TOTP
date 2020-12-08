//
//  SettingViewNavigationWrapper.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import SwiftUI

struct SettingViewWrapper<Content: View>: View {
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
                    .navigationBarItems(
                        leading: Button(action: {
                            // 이전 화면으로 돌아가기 - Object 어쩌구 쓰면 될 듯
                        }, label: {
                            Text("완료").foregroundColor(.black)
                                .onTapGesture {
                                    print("완료, 이전화면으로 기기")
                                }
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

//
//  SettingView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/07.
//

import SwiftUI

struct SettingView: View {
    
    @State var tokens = Token.dummy()
    var columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack {
            
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 0
                ) {
                    Section(header:
                                HStack {
                                    Text("Section 1")
                                        .foregroundColor(Color(UIColor.systemGray))
                                    Spacer()
                                }.padding()
                    ) {
                        ZStack {
                            Rectangle().fill(Color.red)
                            VStack {
                                Divider().padding(0)
                                ForEach(tokens) { token in
                                    SettingRow(token: token)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Section(header: Text("Section 2").font(.title)) {
                        ForEach(11...20, id: \.self) { index in
                            HStack {
                                Text("\(index)")
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .background(Color(UIColor.systemGray6))
        .navigationBarHidden(false)
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                // 이전 화면으로 돌아가기 - Object 어쩌구 쓰면 될 듯
            }, label: {
                Text("완료").foregroundColor(.black)
            }),
            trailing: Button(action: {
            }, label: {
                Image(systemName: "arrow.counterclockwise")
                    .foregroundColor(.black)
            })
        )
    }
}

struct SettingRow: View {
    var token: Token
    
    var body: some View {
        VStack {
            HStack {
                Text("\(token.name ?? "dd")")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .frame(height: 40)
            Divider()
                .padding(0)
        }
    }
}

struct SettingPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
    
}

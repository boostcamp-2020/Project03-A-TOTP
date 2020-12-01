//
//  TokenEditView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI

struct TokenEditView: View {
    
    // MARK: Property
    
    @State var isEditing = false
    @State var text = ""
    @State private var segmentedMode = 0
    @State private var segmentList = ["색상", "아이콘"]
    @EnvironmentObject var navigationFlow: NavigationFlowObject
    
    // TokenEditview에 들어갈 아이들
    // var qrcode: String? // 추가 모드일 때
    // var token: Token? // 편집 모드일 때
    // var service: TokenService
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { geometry in
            
            let geometryWidth = geometry.size.width
            let isSmallDevice = geometry.size.width < 325
            
            VStack(spacing: 16) {
                Spacer()
                VStack(spacing: isSmallDevice ? 16 : 32) {
                    Image.search
                        .resizable()
                        .frame(minWidth: 50,
                               maxWidth: 80,
                               minHeight: 50,
                               maxHeight: 80)
                        .padding(geometryWidth * 0.1)
                        .aspectRatio(1.0, contentMode: .fit)
                        .background(LinearGradient.mint)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    
                    TextField("토큰이름을 입력하세요", text: $text)
                        .padding(6)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .multilineTextAlignment(TextAlignment.center)
                }
                .padding(.horizontal, geometryWidth * 0.22)
                .padding(.top, 20)
                Spacer()
                VStack(spacing: isSmallDevice ? 20 : 40) {
                    Picker("palette", selection: $segmentedMode) {
                        Text(segmentList[0]).tag(0)
                        Text(segmentList[1]).tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onTapGesture {
                        segmentedMode = segmentedMode == 0 ? 1 : 0
                    }
                    
                    segmentedMode == 0 ? PaletteView(geometry: geometry) : nil
                    segmentedMode == 1 ? IconView() : nil
                }
                .padding(.horizontal, isSmallDevice ? 20 : 40)

                isSmallDevice ? nil : Spacer()
                
                Button(action: {
                    print("저장 버튼 Did Tap")
                }, label: {
                    HStack {
                        Spacer()
                        Text("저장")
                            .foregroundColor(.white)
                        Spacer()
                    }
                })
                .frame(width: 85)
                .padding(.vertical, 10)
                .background(LinearGradient.mint)
                .cornerRadius(15)

            }
            .navigationBarHidden(false)
            .navigationBarTitle("토큰 추가", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {
                    navigationFlow.isActive = false
                }, label: {
                    Text("취소").foregroundColor(.black)
                }),
                trailing: Button(action: {
                    navigationFlow.isActive = false
                }, label: {
                    Text("저장").foregroundColor(.black)
                })
            )
            .background(Color.white)
            .onTapGesture {
                hideKeyboard()
            }
        }
        Spacer()
    }
}

struct TokenEditView_Previews: PreviewProvider {
    static var previews: some View {
        TokenEditView()
    }
}

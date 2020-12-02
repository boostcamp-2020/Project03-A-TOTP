//
//  TokenEditView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI

struct TokenEditState {
    var service: TokenServiceable
    var qrCode: String?
    var token: Token?
}

enum TokenEditInput {
    case addToken(_ token: Token)
    case changeColor(_ name: String)
    case changeIcon(_ name: String)
}

struct TokenEditView: View {
    
    // MARK: Property
    
    @ObservedObject var viewModel: AnyViewModel<TokenEditState, TokenEditInput>
    @EnvironmentObject var navigationFlow: NavigationFlowObject
    
    @State var text = ""
    @State private var segmentedMode = 0
    @State private var segmentList = ["색상", "아이콘"]
    
    init(service: TokenServiceable, token: Token?, qrCode: String?) {
        viewModel = AnyViewModel(TokenEditViewModel(service: service,
                                                    token: token,
                                                    qrCode: qrCode))
        
    }
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { geometry in
            
            let geometryWidth = geometry.size.width
            let isSmallDevice = geometry.size.width < 325
            
            VStack(spacing: 16) {
                Spacer()
                
                VStack(spacing: isSmallDevice ? 16 : 32) {
                    
                    viewModel.state.token?.icon?.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: geometryWidth * 0.125,
                               maxWidth: geometryWidth * 0.2,
                               minHeight: geometryWidth * 0.125,
                               maxHeight: geometryWidth * 0.2)
                        .padding(geometryWidth * 0.1)
                        .background(viewModel.state.token?.color?.linearGradientColor()
                                        ?? LinearGradient.mint)
                        
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    
                    TextField(viewModel.state.token?.tokenName ?? "토큰이름을 입력하세요",
                              text: $text)
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
                    
                    segmentedMode == 0 ?
                        ColorView(geometry: geometry).environmentObject(viewModel) : nil
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
                .background(viewModel.state.token?.color?.linearGradientColor()
                                ?? LinearGradient.mint)
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
        let tokenService = TokenService()
        TokenEditView(service: tokenService,
                      token: nil,
                      qrCode: nil)
    }
}

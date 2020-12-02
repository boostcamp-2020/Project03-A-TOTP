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
    var token: Token
}

enum TokenEditInput {
    case addToken
    case changeName(_ name: String)
    case changeColor(_ name: String)
    case changeIcon(_ name: String)
}

struct TokenEditView: View {
    
    // MARK: Property
    
    @ObservedObject var viewModel: AnyViewModel<TokenEditState, TokenEditInput>
    @EnvironmentObject var navigationFlow: NavigationFlowObject
    @State private var text = ""
    @State private var segmentedMode = 0
    @State private var segmentList = ["색상", "아이콘"]
    @State private var showingAlert: Bool = false
    
    init(service: TokenServiceable, token: Token?, qrCode: String?) {
        viewModel = AnyViewModel(TokenEditViewModel(service: service,
                                                    token: token,
                                                    qrCode: qrCode))
        print("token: \(String(describing: token)), qrCode Key : \(String(describing: qrCode))")
    }
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { geometry in
            
            let geometryWidth = geometry.size.width
            let isSmallDevice = geometry.size.width < 325
            
            VStack(spacing: 16) {
                Spacer()
                
                VStack(spacing: isSmallDevice ? 16 : 32) {
                    
                    viewModel.state.token.icon?.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: geometryWidth * 0.125,
                               maxWidth: geometryWidth * 0.2,
                               minHeight: geometryWidth * 0.125,
                               maxHeight: geometryWidth * 0.2)
                        .padding(geometryWidth * 0.1)
                        .background(viewModel.state.token.color?.linearGradientColor()
                                        ?? LinearGradient.mint)
                        
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    
                    TextField(viewModel.state.token.tokenName ?? "토큰이름을 입력하세요",
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
                    
                    segmentedMode == 0 ? ColorView(
                        action: { name in
                            changeColor(name)
                        },
                        geometryWidth: geometryWidth
                    ) : nil

                    segmentedMode == 1 ? IconView(action: { name in
                        changeIcon(name)
                    }) : nil
                }
                .padding(.horizontal, isSmallDevice ? 20 : 40)

                isSmallDevice ? nil : Spacer()
                
                Button(action: {
                    showingAlert = text.isEmpty || text.count > 17
                    if !showingAlert {
                        dismiss()
                        addToken()
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Text("저장")
                            .foregroundColor(.white)
                        Spacer()
                    }
                })
                .modifier(AlertModifier(isShowing: showingAlert))
                .frame(width: 85)
                .padding(.vertical, 10)
                .background(viewModel.state.token.color?.linearGradientColor()
                                ?? LinearGradient.mint)
                .cornerRadius(15)
            }
            .navigationBarHidden(false)
            .navigationBarTitle("토큰 추가", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {
                    dismiss()
                }, label: {
                    Text("취소").foregroundColor(.black)
                }),
                trailing: Button(action: {
                    dismiss()
                    addToken()
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

// MARK: Views

extension TokenEditView {
    
}


// MARK: Methods

extension TokenEditView {
    
    func addToken() {
        viewModel.trigger(.changeName(text))
        viewModel.trigger(.addToken)
    }
    
    func changeColor(_ name: String) {
        viewModel.trigger(.changeColor(name))
    }
    
    func changeIcon(_ name: String) {
        viewModel.trigger(.changeIcon(name))
    }
    
    func dismiss() {
        navigationFlow.isActive = false
    }
    
}

// MARK: ViewModifier

struct AlertModifier: ViewModifier {
    @State var isShowing: Bool
    
    func body(content: Content) -> some View {
        return content
            .alert(isPresented: $isShowing) {
                Alert(title: Text("토큰 정보 입력"),
                      message: Text("17자 이내의 이름을 작성해주세요"),
                      dismissButton: .default(Text("네")))
            }
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

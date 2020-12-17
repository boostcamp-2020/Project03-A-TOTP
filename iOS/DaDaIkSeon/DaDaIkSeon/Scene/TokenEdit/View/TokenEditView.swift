//
//  TokenEditView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI

struct TokenEditView: View {
    
    // MARK: Property
    
    @StateObject private var viewModel: AnyViewModel<TokenEditState, TokenEditInput>
    @ObservedObject var linkManager: MainLinkManager
    @ObservedObject private var entry = Entry(limit: 17)
    @State private var showingAlert = false
    @State private var segmentedMode = 0
    var refresh: () -> Void
    
    private var segmentList = ["색상", "아이콘"]
    
    init(linkManager: ObservedObject<MainLinkManager>,
         service: TokenServiceable,
         token: Token?,
         qrCode: String?,
         refresh: @escaping () -> Void
    ) {
        _linkManager = linkManager
        _viewModel = StateObject(
            wrappedValue: AnyViewModel(TokenEditViewModel(service: service,
                                                          token: token,
                                                          qrCode: qrCode)))
        self.refresh = refresh
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
                    
                    TextField(viewModel.state.token.name ?? "토큰이름을 입력하세요",
                              text: $entry.text)
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
                    paletteView
                    segmentedMode == 0 ? ColorView(action: { name in changeColor(name) },
                                                   geometryWidth: geometryWidth) : nil
                    segmentedMode == 1 ? IconView(action: { name in changeIcon(name) }) : nil
                }
                .padding(.horizontal, isSmallDevice ? 20 : 40)
                
                isSmallDevice ? nil : Spacer()
                
                saveButton
                    .foregroundColor(.white)
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
                leading: cancelButton,
                trailing: saveButton.foregroundColor(.black)
            )
            .background(Color.white)
            .onTapGesture {
                hideKeyboard()
            }
            .onAppear {
                entry.text = viewModel.state.token.name ?? ""
            }
        }
        Spacer()
    }
}

extension TokenEditView {
    
    var paletteView: some View {
        Picker("palette", selection: $segmentedMode) {
            Text(segmentList[0]).tag(0)
            Text(segmentList[1]).tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .onTapGesture {
            withAnimation {
                segmentedMode = segmentedMode == 0 ? 1 : 0
            }
        }
    }
    
    var saveButton: some View {
        Button(action: {
            showingAlert = entry.text.isEmpty || entry.text.count > 17
            if !showingAlert {
                addToken()
                dismiss()
            }
        }, label: {
            HStack {
                Spacer()
                Text("저장")
                Spacer()
            }
        })
        .modifier(AlertModifier(isShowing: $showingAlert))
    }
    
    var cancelButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Text("취소").foregroundColor(.black)
        })
    }
    
}

// MARK: Methods

extension TokenEditView {
    
    func addToken() {
        viewModel.trigger(.changeName(entry.text))
        viewModel.trigger(.addToken)
        refresh()
    }
    
    func changeColor(_ name: String) {
        viewModel.trigger(.changeColor(name))
    }
    
    func changeIcon(_ name: String) {
        viewModel.trigger(.changeIcon(name))
    }
    
    func dismiss() {
        linkManager.change(.main)
    }
    
}

// MARK: ViewModifier

struct AlertModifier: ViewModifier {
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        return content
            .alert(isPresented: $isShowing) {
                Alert(title: Text("토큰 정보 입력"),
                      message: Text("17자 이내의 이름을 작성해주세요"),
                      dismissButton: .default(Text("네")))
            }
    }
}
//
//struct TokenEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        let tokenService = TokenService(StorageManager())
//        TokenEditView(service: tokenService,
//                      token: nil,
//                      qrCode: nil)
//    }
//}

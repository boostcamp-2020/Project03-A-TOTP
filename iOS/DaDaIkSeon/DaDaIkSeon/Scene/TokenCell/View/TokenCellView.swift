//
//  TokenCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI
import CryptoKit

struct TokenCellView: View {
    
    // MARK: ViewModel
    
    @ObservedObject var viewModel: AnyViewModel<TokenCellState, TokenCellInput>
    
    // MARK: Property
    
    @Binding var checkBoxMode: Bool
    private var isSelected: Bool
    private var isMainCell: Bool
    
    init(service: TokenServiceable,
         token: Token,
         isMain: Bool,
         checkBoxMode: Binding<Bool>,
         isSelected: Bool?,
         refreshAction: (() -> Void)? = nil) {
        viewModel = AnyViewModel(
            TokenCellViewModel(service: service,
                               token: token,
                               isMainCell: isMain,
                               refreshAction: refreshAction))
        
        self.isMainCell = isMain
        self.isSelected = isSelected ?? false
        _checkBoxMode = checkBoxMode
    }
    
    // MARK: Body
    
    var body: some View {
        
        ZStack {
            // MARK: 이모티콘, 설정 버튼, 복사 버튼
            VStack {
                
                TopButtonViews(
                    checkBoxMode: $checkBoxMode,
                    token: viewModel.state.token,
                    isChecked: isSelected,
                    action: {
                        checkBoxMode ? nil : showEditView()
                    })
                    .sheet(isPresented: $viewModel.state.isShownEditView,
                           content: { 
                            TokenEditView(
                                linkManager: ObservedObject(wrappedValue: MainLinkManager()),
                                service: viewModel.state.service,
                                token: viewModel.state.token,
                                qrCode: nil, refresh: {
                                    viewModel.trigger(.hideEditView)
                                })
                           })
                Spacer()
                
                if !isMainCell {
                    TokenNameView(tokenName: viewModel.state.token.name)
                    TokenPasswordView(password: viewModel.state.password, isMain: isMainCell)
                } else {
                    CopyButtonView {
                        copyPassword()
                    }
                }
            }
            .background(viewModel.state.token.color?.linearGradientColor() ?? LinearGradient.pink)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1),
                    radius: 10,
                    x: 0.0,
                    y: 0.3)
            
            if isMainCell {
                // MARK: 프로그레스 바
                CircularProgressBar(
                    progressAmount: viewModel.state.timeAmount,
                    totalTime: TOTPTimer.shared.totalTime)
                    .frame(height: 170)
                
                // MARK: 이름, 비밀번호, 시간 텍스트 뷰
                TokenInfoViews(name: viewModel.state.token.name ?? "",
                               password: viewModel.state.password,
                               leftTime: viewModel.state.leftTime)
            }
            
        }
        .animation(nil)
        .animation(.default)
//        .rotationEffect(.degrees(rotaionDegree(checkBoxMode: checkBoxMode)))
//        .animation(checkBoxMode ?
//                    Animation.easeInOut(duration: Double().randomDgree())
//                    .repeatForever(autoreverses: true) : Animation.default)
    }
}

private extension TokenCellView {
    
    func copyPassword() {
        UIPasteboard.general.string = viewModel.state.password
    }
    
    func showEditView() {
        viewModel.trigger(.showEditView)
    }
    
    func hideEditView() {
        viewModel.trigger(.hideEditView)
    }
    
    func rotaionDegree(checkBoxMode: Bool) -> Double {
        checkBoxMode ? 1.5 : 0
    }
    
}

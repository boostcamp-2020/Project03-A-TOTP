//
//  TokenCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI
import CryptoKit

struct TokenCellState {
    var service: TokenServiceable
    var token: Token
    var password: String
    var leftTime: String
    var timeAmount: Double
    var isShownEditView: Bool
}

enum TokenCellInput {
    case showEditView
    case hideEditView
}

struct TokenCellView: View {
    
    // MARK: ViewModel
    
    @ObservedObject var viewModel: AnyViewModel<TokenCellState, TokenCellInput>
    
    // MARK: Property
    
    @Binding var checkBoxMode: Bool
    var isSelected: Bool
    
    var isMainCell: Bool
    
    init(service: TokenServiceable,
         token: Token,
         isMain: Bool,
         checkBoxMode: Binding<Bool>,
         isSelected: Bool?,
         refreshAction: (() -> Void)? = nil) {
        
        viewModel = AnyViewModel(TokenCellViewModel(service: service,
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
                           onDismiss: { hideEditView() },
                           content: { 
                            TokenEditView(service: viewModel.state.service,
                                          token: viewModel.state.token,
                                          qrCode: nil)
                           })
                Spacer()
                
                if !isMainCell {
                    TokenNameView(tokenName: viewModel.state.token.tokenName)
                    TokenPasswordView(password: viewModel.state.password, isMain: isMainCell)
                } else {
                    CopyButtonView {
                        copyPassword()
                    }
                }
            }
            .background(viewModel.state.token.color?.linearGradientColor() ?? LinearGradient.pink)
            .cornerRadius(15)
            .shadow(color: Color.shadow, radius: 6, x: 0, y: 3.0)
            
            if isMainCell {
                // MARK: 프로그레스 바
                CircularProgressBar(
                    progressAmount: viewModel.state.timeAmount,
                    totalTime: TOTPTimer.shared.totalTime)
                    .frame(height: 170)
                
                // MARK: 이름, 비밀번호, 시간 텍스트 뷰
                TokenInfoViews(name: viewModel.state.token.tokenName ?? "",
                               password: viewModel.state.password,
                               leftTime: viewModel.state.leftTime)
            }
            
        }
        .modifier( Shake(animatableData: checkBoxMode ?  5 : 0) )
        
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 3
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    var sinValue: CGFloat {
        sin(animatableData * .pi * CGFloat(shakesPerUnit))
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(translationX: amount * sinValue, y: 0))
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
    
}

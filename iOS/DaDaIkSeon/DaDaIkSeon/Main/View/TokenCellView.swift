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
    
    var isMain: Bool
    let zStackHeight: CGFloat = 200.0
    
    init(service: TokenServiceable, token: Token,
         isMain: Bool, checkBoxMode: Binding<Bool>, isSelected: Bool?) {
        viewModel = AnyViewModel(TokenCellViewModel(service: service, token: token))
        self.isMain = isMain
        _checkBoxMode = checkBoxMode
        self.isSelected = isSelected ?? false
    }
    
    // MARK: Body
    
    var body: some View {
        
        ZStack {
            // MARK: 이모티콘, 설정 버튼, 복사 버튼
            VStack {
                
                TopButtonViews(
                    checkBoxMode: $checkBoxMode,
                    isChecked: isSelected,
                    action: {
                        checkBoxMode ?
                            nil
                            : viewModel.trigger(.showEditView)
                    })
                    .sheet(isPresented: $viewModel.state.isShownEditView,
                           onDismiss: { viewModel.trigger(.hideEditView) },
                           content: { TokenEditView() })
                
                Spacer()
                
                if !isMain {
                    TokenNameView(tokenName: viewModel.state.token.tokenName)
                    TokenPasswordView(password: viewModel.state.password, isMain: isMain)
                } else {
                    CopyButtonView {
                        //mainCellViewModel.copyButtonDidTab()
                    }
                }
            }
            .background(viewModel.state.token.color?.linearGradientColor() ?? LinearGradient.pink)
            .cornerRadius(15)
            .shadow(color: Color.shadow, radius: 6, x: 0, y: 3.0)
            
            if isMain {
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
        .frame(height: isMain ? zStackHeight : nil)
    }
}
//
//struct TokenCellView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let service = TokenService()
//        TokenCellView(service: service,
//                      token: Token(),
//                      isMain: true)
//    }
//
//}

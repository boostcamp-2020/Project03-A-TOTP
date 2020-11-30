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
    var isShownEditView: Bool
    var password: String
    var leftTime: String
    var timeAmount: Double
}

enum TokenCellInput {
    case showEditView
}

struct TokenCellView: View {
    
    // MARK: ViewModel
    
    @ObservedObject var viewModel: AnyViewModel<TokenCellState, TokenCellInput>
    
    // MARK: Property
    
    @State var isShownEditView = false
    var isMain: Bool
    let zStackHeight: CGFloat = 200.0
    
    init(service: TokenServiceable, token: Token, isMain: Bool) {
        viewModel = AnyViewModel(TokenCellViewModel(service: service, token: token))
        self.isMain = isMain
    }
    
    // MARK: Body
    
    var body: some View {
        
        ZStack {
            // MARK: 이모티콘, 설정 버튼, 복사 버튼
            VStack {
                HStack {
                    Image(systemName: "heart.circle")
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20, alignment: .top)
                    Spacer()
                    Button(action: {
                        viewModel.trigger(.showEditView)
                    }, label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .top)
                            .foregroundColor(.white)
                    })
                    .sheet(isPresented: $isShownEditView) {
                        TokenEditView()
                    }
                }
                .padding(.horizontal, 12)
                .frame(height: 50, alignment: .center) // 크기를 자동으로 하는 방법 고민
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
                VStack(spacing: 5) {
                    Spacer()
                        .frame(height: 50)
                    Text(viewModel.state.token.tokenName ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: 11))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .frame(
                            width: 90,
                            alignment: .center)
                    (Text(viewModel.state.password.prefix(3))
                        + Text(" ")
                        + Text(viewModel.state.password.suffix(3)))
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .kerning(3)
                    
                    Text(viewModel.state.leftTime)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height: 30)
                }
            }
            
        }
        .frame(height: isMain ? zStackHeight : nil)
    }
}

struct TokenCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        let service = TokenService()
        TokenCellView(service: service,
                      token: Token(),
                      isMain: true)
    }
    
}

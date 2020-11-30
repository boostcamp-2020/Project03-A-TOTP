//
//  MainCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI

struct MainCellView: View {
    
    // MARK: ViewModel
    @ObservedObject var viewModel: AnyViewModel<TokenCellState, TokenCellInput>

    init(service: TokenServiceable, token: Token) {
        viewModel = AnyViewModel(TokenCellViewModel(service: service, token: token))
    }
    
    // MARK: Property
    let zStackHeight: CGFloat = 200.0
    
    // MARK: Body
    var body: some View {
        
        ZStack {
            // MARK: 이모티콘, 설정 버튼, 복사 버튼
            VStack {
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        viewModel.trigger(.showEditView)
                    }, label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    })
                }
                .padding(.horizontal, 12)
                .frame(height: 50, alignment: .center)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        //mainCellViewModel.copyButtonDidTab()
                    }, label: {
                        Image(systemName: "doc.on.doc")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        // 배경색이랑 같게
                    })
                    //.background(Color.white)
                    
                }
                .padding(.horizontal, 12)
                .frame(height: 50, alignment: .center)
            }
            .background(LinearGradient.blue)
            .cornerRadius(15)
            .shadow(color: Color.shadow, radius: 6, x: 0, y: 3)
            
//            // MARK: 프로그레스 바
//            CircularProgressBar(
//                progressAmount: viewModel.timeAmount,
//                totalTime: viewModel.totalTime)
//                .frame(height: 170)
            
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
                
//                Text(viewModel.state.timeString)
//                    .font(.system(size: 15))
//                    .fontWeight(.bold)
//                    .padding(.top, 10)
//                    .foregroundColor(.white)
//                Spacer()
//                    .frame(height: 30)
            }
        }
        .frame(height: zStackHeight)
        .padding(.horizontal, 12)
    }
}

struct CircularProgressBar: View {
    
    @Binding var progressAmount: Double
    var totalTime: Double
    let strokeWidth = 10.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: CGFloat(strokeWidth))
                .opacity(0.3)
                .foregroundColor(Color.white)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progressAmount / totalTime))
                .stroke(style: StrokeStyle(
                            lineWidth: CGFloat(strokeWidth),
                            lineCap: .round,
                            lineJoin: .round))
                .foregroundColor(Color.white)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.none)
        }
    }
    
}

//struct MainCellView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        //PreviewWrapper()
//        MainCellView(mainCellViewModel: MainCellViewModel())
//    }
////
////        struct PreviewWrapper: View {
////
////            @State var viewModel = MainCellViewModel()
////
////            var body: some View {
////                MainCellView(mainCellVM: $viewModel)
////            }
////        }
//
//}

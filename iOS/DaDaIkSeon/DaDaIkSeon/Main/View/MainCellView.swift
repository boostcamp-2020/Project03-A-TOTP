//
//  MainCellView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/24.
//

import SwiftUI

struct MainCellView: View {
    
    var mainCellVM: MainCellViewModel = MainCellViewModel()
    
    @State private var tokenName = "토큰의이름은두줄두줄두줄두줄두줄두줄두줄두줄두줄"
    @State private var timeString = "15"
    @State private var timeAmount = 0.0
    @State private var password = "333 444"
    
    let totalTime = 30.0
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // 1
            VStack {
                HStack {
                    Image(systemName: "circle")
                    Spacer()
                    Image(systemName: "circle")
                }
                .padding(.horizontal, 12)
                .frame(height: 50, alignment: .center) // 크기를 자동으로 하는 방법 고민
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "circle")
                }
                .padding(.horizontal, 12)
                .frame(height: 50, alignment: .center)
            }
            .background(Color.green)
            .cornerRadius(15)
            
            // 2
            CircularProgressBar(progressAmount: $timeAmount, totalTime: totalTime)
                .frame(height: 170)
                .onReceive(timer, perform: { _ in
                    if timeAmount < totalTime - 0.01 {
                        timeAmount += 0.01
                    } else {
                        timeAmount = 0.0
                    }
                })
                  
            // 3
            VStack(spacing: 10) {
                Spacer()
                    .frame(height: 30)
                Text(tokenName)
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(
                        width: 150,
                        alignment: .center)
                Text(password)
                Text(timeString)
                    .padding(.top)
                    .font(.system(size: 20))
                    
                    .onReceive(timer, perform: { _ in
                        timeString = "\(Int(timeAmount) + 1)"
                    })
                Spacer()
                    .frame(height: 30)
            }
            
        }
        .frame(height: 200)
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
                .animation(.linear)
        }
    }
    
}

struct MainCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        //PreviewWrapper()
        MainCellView()
    }
    
    //    struct PreviewWrapper: View {
    //
    //        @State var viewModel = MainCellViewModel()
    //
    //        var body: some View {
    //            MainCellView(mainCellVM: $vm)
    //        }
    //    }
    
}

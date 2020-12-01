//
//  TokenCellView+SubViews.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/01.
//

import SwiftUI

struct TopButtonViews: View {
    
    var action: () -> Void
    @Binding var isShownEditView: Bool
    
    var body: some View {
        
        HStack {
            Image(systemName: "heart.circle")
                .foregroundColor(.white)
                .frame(width: 20, height: 20, alignment: .top)
            Spacer()
            Button(action: {
                action()
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
    }
}

struct CircularProgressBar: View {
    
    var progressAmount: Double
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

struct TokenInfoViews: View {
    
    var name: String
    var password: String
    var leftTime: String
    
    var body: some View {
        VStack(spacing: 5) {
            Spacer()
                .frame(height: 50)
            Text(name)
                .foregroundColor(.white)
                .font(.system(size: 11))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(
                    width: 90,
                    alignment: .center)
            (Text(password.prefix(3))
                + Text(" ")
                + Text(password.suffix(3)))
                .foregroundColor(.white)
                .font(.system(size: 28))
                .fontWeight(.bold)
                .kerning(3)
            Text(leftTime)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(.white)
            Spacer()
                .frame(height: 30)
        }
    }
}

struct CopyButtonView: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                action()
            }, label: {
                Image(systemName: "doc.on.doc")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
            })
        }
        .padding(.horizontal, 12)
        .frame(height: 50, alignment: .center)
    }
}

struct TokenPasswordView: View {
    
    var password: String
    var isMain: Bool
    
    var body: some View {
        HStack {
            (Text(password.prefix(3))
                + Text(" ")
                + Text(password.suffix(3)))
                .foregroundColor(.white)
                .font(.system(size: isMain ? 28 : 18))
                .fontWeight(.bold)
                .kerning(3)
            isMain ? nil : Spacer()
        }
        .padding([.horizontal, .bottom], 12)
    }
    
}

struct TokenNameView: View {
    
    var tokenName: String?
    
    var body: some View {
        HStack {
            Text(tokenName ?? "")
                .font(.system(size: 11))
                .foregroundColor(.white)
                .lineLimit(2)
            Spacer()
        }
        .padding(.horizontal, 12)
    }
}

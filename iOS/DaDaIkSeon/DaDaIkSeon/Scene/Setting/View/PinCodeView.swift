//
//  PinCodeView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import SwiftUI

struct PinCodeView: View {
    
    @State var code: [String] = []
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                Image.logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                
                Spacer()
                
                Text("PIN 번호를 세팅 하세요")
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack(spacing: 20) {
                    ForEach(code, id: \.self) { _ in
                        Circle()
                            .foregroundColor(Color.navy2)
                            .frame(width: 18, height: 18)
                    }
                }
                .padding(.vertical)
                
                Spacer()
                
                NumberPad(codes: $code)
            }
            .animation(.spring())
        }
    }
}

struct NumberType: Identifiable {
    var id: Int
    var row: [NumberRow]
}

struct NumberRow: Identifiable {
    var id: Int
    var value: String
}

struct NumberPad: View {
    
    @Binding var codes: [String]
    
    var deleteImageName = "delete"
    var datas = [
        NumberType(id: 0, row: [NumberRow(id: 0, value: "1"),
                                NumberRow(id: 1, value: "2"),
                                NumberRow(id: 2, value: "3")]),
        NumberType(id: 1, row: [NumberRow(id: 0, value: "4"),
                                NumberRow(id: 1, value: "5"),
                                NumberRow(id: 2, value: "6")]),
        NumberType(id: 2, row: [NumberRow(id: 0, value: "7"),
                                NumberRow(id: 1, value: "8"),
                                NumberRow(id: 2, value: "9")]),
        NumberType(id: 3, row: [NumberRow(id: 0, value: ""),
                                NumberRow(id: 1, value: "0"),
                                NumberRow(id: 2, value: "delete")])
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ForEach(datas) { data in
                HStack(spacing: getspacing()) {
                    ForEach(data.row) { row in
                        makeNumberButton(value: row.value)
                    }
                }
            }
        }
        .foregroundColor(.black)
    }
}

private extension NumberPad {
    
    func makeNumberButton(value: String) -> some View {
        Button(action: {
            if value == deleteImageName {
                codes.removeLast()
            } else {
                if !value.isEmpty { codes.append(value) }
                if codes.count == 4 {
                    print(getCode()) // 입력을 다 했을 때의 로직은 여기에...
                    codes.removeAll()
                }
            }
        }, label: {
            if value == deleteImageName {
                value.toImage()
                    .padding(.vertical)
                    .frame(width: 20)
            } else {
                Text(value)
                    .font(.system(size: 22))
                    .padding(.vertical)
                    .frame(width: 20)
                    .background(
                        Rectangle()
                            .foregroundColor(value.isEmpty
                                                ? Color.clear : Color(.tertiarySystemFill))
                            .frame(width: 40, height: 40, alignment: .center)
                            .cornerRadius(10)
                    )
            }
        })
    }
    
    func getspacing() -> CGFloat {
        return UIScreen.main.bounds.width / 4
    }
    
    func getCode() -> String {
        return codes.joined()
    }
    
}

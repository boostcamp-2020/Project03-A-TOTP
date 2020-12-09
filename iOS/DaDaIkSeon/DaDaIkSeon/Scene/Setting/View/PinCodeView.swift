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

struct NumberPad: View {
    
    @Binding var codes: [String]
    
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
                                NumberRow(id: 2, value: "delete.left.fill")])
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
            if value == "delete.left.fill" {
                codes.removeLast()
            } else {
                codes.append(value)
                if codes.count == 4 {
                    print(getCode())
                    NotificationCenter.default.post(name: NSNotification.Name("Success"),
                                                    object: nil)
                    codes.removeAll()
                }
            }
        }, label: {
            if value == "delete.left.fill" {
                Image(systemName: value)
                    .padding(.vertical)
            } else {
                Text(value)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                    .frame(width: 20)
            }
        })
    }
    
    func getspacing() -> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
    
    func getCode() -> String {
        var allCode = ""
        for code in codes {
            allCode += code
        }
        return allCode.replacingOccurrences(of: " ", with: "")
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

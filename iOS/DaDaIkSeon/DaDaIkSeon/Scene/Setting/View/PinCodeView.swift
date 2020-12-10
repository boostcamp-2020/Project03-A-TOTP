//
//  PinCodeView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import SwiftUI

// 아래 모드에 따라 다르게 화면 전환이 일어난다.
enum PinCodeViewMode: Equatable {
    case setup
    // 핀넘버 설정 - 두 번 code를 체크하고 맞으면 completion(pincode) 호출한다.
    // 두 개의 값이 맞기만 하면 completion 호출
    // 이 completion에는 viewmodel의 핀 넘버 등록 함수가 있다.
    case auth(_ pincode: String) // 화면 시작할 때 이 값을 넣어준다.
    // 핀넘버 사용 - 한 번 code를 체크하고,
    // 일치할 때에만 핀 넘버 화면을 종료하고 completion 호출한다.
    // code가 맞는지는 넘겨준 값으로 확인
    // completion에는 메인화면으로 가게 만드는 상태값이 있다.
    // 취소가 나오면 안된다.
    
    static func == (lhs: PinCodeViewMode, rhs: PinCodeViewMode) -> Bool {
        switch (lhs, rhs) {
        case (.setup, .setup): return true
        case (.setup, .auth): return false
        case (.auth, .setup): return false
        case (.auth, .auth): return false
        }
    }
}

struct PinCodeView: View {
    
    @State private var code: [String] = []
    @ObservedObject private var numberChecker = NumberChecker()
    private let pincodeViewMode: PinCodeViewMode
    private let completion: (String) -> Void
    
    init(mode: PinCodeViewMode, completion: @escaping (String) -> Void) {
        self.pincodeViewMode = mode
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                Image.logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                
                Spacer()
                
                if numberChecker.isFirst() {
                    Text("PIN 번호를 설정 하세요")
                        .foregroundColor(Color.gray)
                } else {
                    Text("PIN 번호를 한 번 더 입력해주세요.")
                        .foregroundColor(Color.gray)
                }
              
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
                
                NumberPad(codes: $code,
                          pincodeViewMode: pincodeViewMode,
                          completion: completion,
                          lastNumber: numberChecker)
            }
            .animation(.spring())
        }
        .navigationBarHidden(true)
        
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

class NumberChecker: ObservableObject {
    private var lastNumber: String = ""
    
    func setFirstNumber(_ number: String) {
        lastNumber = number
    }
    
    func compare(_ target: String) -> Bool {
        lastNumber == target
    }
    
    func isFirst() -> Bool {
        lastNumber.count == 0
    }
}

struct NumberPad: View {
    
    @Binding var codes: [String]
    let pincodeViewMode: PinCodeViewMode
    let completion: (String) -> Void
    @ObservedObject var lastNumber: NumberChecker
    
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
    
    var deleteImageName = "delete"
    var cancelButton = "cancel"
    
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
        NumberType(id: 3, row: [NumberRow(id: 0, value: "cancel"),
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
                if !codes.isEmpty { codes.removeLast() }
            } else if value == cancelButton {
                mode.wrappedValue.dismiss()
            } else {
                if !value.isEmpty { codes.append(value) }
                if codes.count == 4 {
                    let inputCode = getCode()
                    switch pincodeViewMode {
                    case .auth(let pincode):
                        if pincode == inputCode {
                            completion(inputCode)
                        } else {
                            codes.removeAll()
                            // 에러 메세지 출력해주기 // alert
                        }
                    case .setup:
                        if lastNumber.isFirst() {
                            lastNumber.setFirstNumber(inputCode)
                            codes.removeAll()
                        } else { // 한번 더!
                            if lastNumber.compare(inputCode) {
                                completion(inputCode)
                            } else {
                                // 다시 입력하라는 메세지 출력
                                codes.removeAll()
                            }
                        }
                    }
                }
            }
        }, label: {
            if value == deleteImageName {
                value.toImage()
                    .padding(.vertical)
                    .frame(width: 20)
            } else if value == cancelButton {
                Text( (pincodeViewMode == .setup) ? "취소" : "")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(.pink1)
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

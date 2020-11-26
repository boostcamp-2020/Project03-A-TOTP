//
//  QRView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI
import CodeScanner

struct QRGuideView: View {
    
    @State var showingScanner = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                showingScanner = true
            }, label: {
                HStack {
                    Spacer()
                    Image(systemName: "camera.fill")
                    Text("QR 코드 스캔")
                    Spacer()
                }
                .foregroundColor(.black)
            })
            .frame(width: 300, height: 50)
            .background(Color(.systemGray6))
            .cornerRadius(30)
            
        }
        .navigationBarHidden(false)
        .navigationBarTitle("QR 코드", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("취소")
                    .foregroundColor(.black)
            })
        )
        .sheet(isPresented: $showingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "-") { result in
                switch result {
                case .success(let code):
                    
                    // 여기서 성공하면 새로운 화면 띄운다.
                    // 키값도 넘겨준다.
                    
                    print(code)
                case .failure(let error):
                    print(error)
                }
                self.showingScanner = false
            }
        }
        
    }
    
}

struct QRGuideView_Previews: PreviewProvider {
    static var previews: some View {
        QRGuideView()
    }
}

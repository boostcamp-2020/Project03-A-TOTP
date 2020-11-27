//
//  QRView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI
import CodeScanner

struct QRGuideView: View {
    
    // MARK: Property
    @State var showingScanner = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    // MARK: Body
    var body: some View {
        
        VStack {
            Spacer()
            
            NavigationLink(
                destination: QRScannerView(showingScanner: .constant(showingScanner)),
                label: {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("QR 코드 스캔")
                    }
                    .foregroundColor(.black)
                })
                .frame(maxWidth: .infinity, maxHeight: 46)
                .background(Color(.systemGray6))
                .cornerRadius(15)
        }
        .padding(.horizontal, 40)
        .navigationBarHidden(false)
        .navigationBarTitle("QR 코드", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                mode.wrappedValue.dismiss()
            }, label: {
                Text("취소")
                    .foregroundColor(.black)
            })
        )
    }
    
}

struct QRScannerView: View {
    
    @Binding var showingScanner: Bool
    
    var body: some View {
        CodeScannerView(codeTypes: [.qr], simulatedData: "-") { result in
            switch result {
            case .success(let code):
                
                // 여기서 성공하면 새로운 화면 띄운다.
                // 키값도 넘겨준다.
                
                print(code)
            case .failure(let error):
                print(error)
            }
            showingScanner = false
        }
    }
    
}



// MARK: Preview
struct QRGuideView_Previews: PreviewProvider {
    static var previews: some View {
        QRGuideView()
    }
}

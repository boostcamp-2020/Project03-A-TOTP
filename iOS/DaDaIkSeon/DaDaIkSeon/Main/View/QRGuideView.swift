//
//  QRView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI

struct QRGuideView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                // QR 스캐너
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
            }))
        
    }
    
}

struct QRGuideView_Previews: PreviewProvider {
    static var previews: some View {
        QRGuideView()
    }
}

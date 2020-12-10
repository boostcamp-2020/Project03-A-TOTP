//
//  QRView.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/11/26.
//

import SwiftUI
import CodeScanner
import AVFoundation

struct QRGuideView: View {
    
    // MARK: Property
    private(set) var service: TokenServiceable
    @State private var qrCodeURL = ""
    @State private var isShownScanner = false
    @State private var isShownEditView: Bool = false
    @State private var isShownCameraCheck: Bool = false
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
    
    // MARK: Body
    var body: some View {
        
        // TODO: 코드 정리 필요. 네비게이션 속성 감싸주기
        VStack {
            Spacer()
            Image.logo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70)
                .padding(.bottom, 30)
            Text("2FA 인증을 위해 웹사이트가 제공하는\nQR코드를 스캔해주세요!")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Spacer()
            Spacer()
            
            Text("보안은 다다익선!\n2FA는 다다익선!\nTOTP는 다다익선!")
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                authoriztionCapture()
            }, label: {
                HStack {
                    Image.camera
                    Text("QR 코드 스캔")
                }
                .foregroundColor(.black)
            })
            .frame(maxWidth: .infinity, maxHeight: 46)
            .background(Color(.systemGray6))
            .cornerRadius(15)
            
            NavigationLink(
                "",
                destination: NavigationLazyView(
                    TokenEditView(service: service,
                                  token: nil,
                                  qrCode: TOTPGenerator.extractKey(from: qrCodeURL))),
                isActive: $isShownEditView
            )
        }
        .padding(.horizontal, 40)
        .navigationBarHidden(false)
        .navigationBarTitle("QR 코드", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                mode.wrappedValue.dismiss()
            }, label: {
                Text("취소").foregroundColor(.black)
            })
        )
        .sheet(isPresented: $isShownScanner) {
            QRScannerView(isShownEditView: $isShownEditView,
                          qrCodeURL: $qrCodeURL)
        }
        .alert(isPresented: $isShownCameraCheck, content: {
            Alert(title: Text("QR 스캔을 원하시면 '설정'을 눌러 '사진' 접근을 허용해주세요"))
        })
    }
}

struct QRScannerView: View {
    
    @Binding var isShownEditView: Bool
    @Binding var qrCodeURL: String
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            CodeScannerView(codeTypes: [.qr], simulatedData: "-") { result in
                switch result {
                case .success(let url):
                    isShownEditView = true
                    qrCodeURL = url
                case .failure(let error):
                    print(error)
                }
                mode.wrappedValue.dismiss()
            }
        }
    }
}

extension QRGuideView {
    func authoriztionCapture() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            isShownScanner = true
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted { isShownScanner = true }
            }
        case .denied: // The user has previously denied access.
            isShownCameraCheck = true
        case .restricted: // The user can't grant access due to restrictions.
            isShownCameraCheck = true
        @unknown default:
            break
        }
    }
}

// MARK: Preview

struct QRGuideView_Previews: PreviewProvider {
    static var previews: some View {
        QRGuideView(service: TokenService(StorageManager()))
    }
}
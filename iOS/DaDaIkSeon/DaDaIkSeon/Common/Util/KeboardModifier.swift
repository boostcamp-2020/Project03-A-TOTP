//
//  KeboardModifier.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/14.
//

import SwiftUI

struct KeyboardManagment: ViewModifier {
    
    @State private var offset: CGFloat = 0
    
    @State var keboardShowObserver: NSObjectProtocol?
    @State var keboardHideObserver: NSObjectProtocol?
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .onAppear {
                    keboardShowObserver =
                        NotificationCenter.default.addObserver(
                            forName: UIResponder.keyboardWillShowNotification,
                            object: nil, queue: .main) { (notification) in
                            guard let keyboardFrame
                                    = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                    as? CGRect else { return }
                            withAnimation(Animation.easeOut(duration: 0.5)) {
                                offset = keyboardFrame.height - geo.safeAreaInsets.bottom
                            }
                        }
                    keboardHideObserver =
                        NotificationCenter.default.addObserver(
                            forName: UIResponder.keyboardWillHideNotification,
                            object: nil, queue: .main) { (notification) in
                            withAnimation(Animation.easeOut(duration: 0.1)) {
                                offset = 0
                            }
                        }
                }
                .onDisappear {
                    NotificationCenter.default.removeObserver(keboardShowObserver)
                    NotificationCenter.default.removeObserver(keboardHideObserver)
                }
                .padding(.bottom, offset)
        }
    }
}
extension View {
    func keyboardManagment() -> some View {
        self.modifier(KeyboardManagment())
    }
}

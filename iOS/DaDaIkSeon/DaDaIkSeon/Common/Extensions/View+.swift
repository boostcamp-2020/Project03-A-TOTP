//
//  View+.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/27.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}

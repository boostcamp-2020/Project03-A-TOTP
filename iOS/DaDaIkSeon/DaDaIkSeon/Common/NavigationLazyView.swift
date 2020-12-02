//
//  NavigationLazyView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/02.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
    
}

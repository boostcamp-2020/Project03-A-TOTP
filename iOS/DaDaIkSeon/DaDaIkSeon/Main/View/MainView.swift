//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = TokenListViewModel()
    
    init() {
        viewModel.fetchTokens()
    }
    
    var body: some View {
        VStack(spacing: 12) {
            MainCellView()
            ScrollView {
                TokenListView(tokens: $viewModel.tokens)
            }
        }.padding([.top, .leading, .trailing])
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

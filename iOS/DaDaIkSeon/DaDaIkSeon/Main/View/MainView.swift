//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: ViewModel
    
    @ObservedObject private var viewModel = MainViewModel()
    
    // MARK: Property
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: 12) {
            HeaderView()
            SearchBarView()
            MainCellView()
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: 12) {
                    Text("?? \(viewModel.searchText)!!")
                    ForEach(viewModel.filteredTokens, id: \.token.id) { token in
                        TokenCellView(viewModel: .constant(token))
                    }
                TokenAddCellView()
                    .frame(minHeight: 100)
                }
                .padding([.leading, .trailing, .bottom], 12)
                .padding(.top, 6)
            }
        }
        .padding(.top)
    }
    
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
    
}

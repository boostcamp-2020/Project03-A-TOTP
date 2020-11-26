//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: ViewModel
    
    @EnvironmentObject private var viewModel: MainViewModel
    
    // MARK: Property
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    @State var isShowing = false
    
    // MARK: Body
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 12) {
                HeaderView()
                SearchBarView()
                viewModel.isSearching ? nil : MainCellView().padding(.bottom, -6)
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 12) {
                        ForEach(viewModel.filteredTokens, id: \.token.id) { token in
                            TokenCellView(viewModel: .constant(token))
                        }
                        viewModel.isSearching ? nil : TokenAddCellView()
                            .onTapGesture {
                                isShowing = true
                            }
                            .frame(minHeight: 100)
                        }
                    .padding([.leading, .trailing, .bottom], 12)
                    .padding(.top, 6)
                }
                .navigationBarHidden(true)
            }
            
        }
        .sheet(isPresented: $isShowing) {
            QRGuideView()
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
    
}

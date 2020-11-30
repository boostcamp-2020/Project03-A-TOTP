//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI

struct MainState {
    var service: TokenServiceable
    var filteredTokens: [Token]
    var searchText: String
    var isSearching: Bool
}

enum MainInput {
    case startSearch(_ text: String)
    case endSearch
}

struct MainView: View {
    
    // MARK: Property
    
    @ObservedObject var viewModel: AnyViewModel<MainState, MainInput>
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    // MARK: Initialization
    
    init(service: TokenServiceable) {
        viewModel = AnyViewModel(MainViewModel(service: service))
    }
    
    // MARK: Body
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 12) {
                viewModel.state.isSearching ? nil : HeaderView()
                SearchBarView().environmentObject(viewModel)
                viewModel.state.isSearching ? nil : MainCellView()
                    .padding(.bottom, -6)
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 12) {
                        ForEach(viewModel.state.filteredTokens) { token in
                            TokenCellView(viewModel: TokenViewModel(token: token))
                        }
                        viewModel.state.isSearching  ? nil : NavigationLink(
                            destination: QRGuideView(),
                            label: {
                                TokenAddCellView()
                            })
                            .frame(minHeight: 100)
                    }
                    .padding([.leading, .trailing, .bottom], 12)
                    .padding(.top, 6)
                }
                .navigationBarHidden(true)
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        let service = TokenService()
        MainView(service: service)
    }

}

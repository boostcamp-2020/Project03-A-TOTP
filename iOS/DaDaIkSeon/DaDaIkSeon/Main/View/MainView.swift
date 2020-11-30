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
    var mainToken: Token
}

enum MainInput {
    case startSearch(_ text: String)
    case endSearch
    case moveToken(_ id: UUID)
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
    
    @Namespace var namespace
    //@State var mainCellToken: Token
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 12) {
                viewModel.state.isSearching ? nil : HeaderView()
                SearchBarView().environmentObject(viewModel)
                
                ScrollView {
                    
                    viewModel.state.isSearching ? nil : TokenCellView(
                        viewModel: TokenCellViewModel(service: viewModel.state.service,
                                                      token: viewModel.state.mainToken)
                    )
                    .matchedGeometryEffect(id: viewModel.state.mainToken.id, in: namespace)
                    .padding(.bottom, -6)
                    
                    LazyVGrid(columns: columns,
                              spacing: 12) {
                        ForEach(viewModel.state.filteredTokens) { token in
                            Button(action: {
                                withAnimation(.spring(response: 0.5)) {
                                    viewModel.trigger(.moveToken(token.id))
                                }
                            }, label: {
                                TokenCellView(
                                    viewModel: TokenCellViewModel(service: viewModel.state.service,
                                                                  token: token)
                                )
                            })
                           .matchedGeometryEffect(id: token.id, in: namespace, isSource: false)
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

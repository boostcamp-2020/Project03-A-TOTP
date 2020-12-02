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
    var checkBoxMode: Bool
    var selectedTokens: [UUID: Bool]
    var settingMode: Bool
    var selectedCount: Int
}

enum MainInput {
    case startSearch(_ text: String)
    case endSearch
    case moveToken(_ id: UUID)
    case showCheckBox
    case hideCheckBox
    case selectCell(_ id: UUID)
    case startSetting
    case endSetting
    case deleteSelectedTokens
}

class NavigationFlowObject: ObservableObject {
    @Published var isActive = false
}

struct MainView: View {
    
    // MARK: ViewModel
    
    @ObservedObject var viewModel: AnyViewModel<MainState, MainInput>
    
    // MARK: Property
    
    @EnvironmentObject var navigationFlow: NavigationFlowObject
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    @Namespace var namespace
    
    // MARK: Initialization
    
    init(service: TokenServiceable) {
        viewModel = AnyViewModel(MainViewModel(service: service))
    }
    
    // MARK: Body
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 12) {
                viewModel.state.isSearching ?
                    nil : HeaderView(viewModel: viewModel)
                
                SearchBarView().environmentObject(viewModel)
                
                ScrollView {
                    let mainTokenId = viewModel.state.mainToken.id
                    viewModel.state.isSearching ?
                        nil : TokenCellView(
                            service: viewModel.state.service,
                            token: viewModel.state.mainToken,
                            isMain: true,
                            checkBoxMode: $viewModel.state.checkBoxMode,
                            isSelected: viewModel.state.selectedTokens[mainTokenId]
                        )
                        .matchedGeometryEffect(id: viewModel.state.mainToken.id, in: namespace)
                    
                    LazyVGrid(columns: columns,
                              spacing: 12) {
                        ForEach(viewModel.state.filteredTokens) { token in
                            Button(action: {
                                if viewModel.state.checkBoxMode {
                                    viewModel.trigger(.selectCell(token.id))
                                } else {
                                    withAnimation(.spring(response: 0.5)) {
                                        viewModel.trigger(.moveToken(token.id))
                                        hideKeyboard()
                                    }
                                }
                                
                            }, label: {
                                TokenCellView(
                                    service: viewModel.state.service,
                                    token: token,
                                    isMain: false,
                                    checkBoxMode: $viewModel.state.checkBoxMode,
                                    isSelected: viewModel.state.selectedTokens[token.id]
                                )
                            })
                            .matchedGeometryEffect(id: token.id, in: namespace, isSource: false)
                        }
                        viewModel.state.isSearching ?
                            nil : NavigationLink(
                                destination: QRGuideView(service: viewModel.state.service)
                                    .environmentObject(navigationFlow),
                                isActive: $navigationFlow.isActive,
                                label: {
                                    TokenAddCellView()
                                        .onTapGesture {
                                            navigationFlow.isActive = true
                                        }
                                }
                            )
                            .frame(minHeight: 100)
                    }
                    .padding(.top, 6)
                    
                }
                .navigationBarHidden(true)
                .padding(.horizontal, 12)
                .padding(.top, 6)
            }
            
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        let service = TokenService()
        MainView(service: service)
    }
    
}

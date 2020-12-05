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
    var isSearching: Bool
    var mainToken: Token
    var checkBoxMode: Bool
    var selectedTokens: [UUID: Bool]
    var settingMode: Bool
    var selectedCount: Int
    var zeroTokenState: Bool
}

enum MainInput {
    case search(_ text: String)
    case startSearch
    case endSearch
    case moveToken(_ id: UUID)
    case showCheckBox
    case hideCheckBox
    case selectCell(_ id: UUID)
    case startSetting
    case endSetting
    case deleteSelectedTokens
    case refreshTokens
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
                    .padding(.top, 12)
                    .padding(.bottom, -6)
                if !viewModel.state.checkBoxMode {
                    SearchBarView(viewModel: viewModel)
                }
                ScrollView {
                    VStack(spacing: 12) {
                        mainCellView.frame(height: 200)
                            .padding(.horizontal, 12)
                            .padding(.top, 6)
                        gridView
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                    }
                }
                .navigationBarHidden(true)
            }
            .onAppear(perform: {
                TOTPTimer.shared.startAll()
                viewModel.trigger(.refreshTokens)
            })
            .onDisappear(perform: {
                TOTPTimer.shared.cancel()
            })
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // MARK: Views
    
    var mainCellView: some View {
        
        Group {
            if viewModel.state.zeroTokenState {
                ZeroTokenView()
            } else {
                let mainTokenId = viewModel.state.mainToken.id
                viewModel.state.isSearching ?
                    nil : TokenCellView(service: viewModel.state.service,
                                        token: viewModel.state.mainToken,
                                        isMain: true,
                                        checkBoxMode: $viewModel.state.checkBoxMode,
                                        isSelected: viewModel.state.selectedTokens[mainTokenId],
                                        refreshAction: {
                                            viewModel.trigger(.refreshTokens)
                                        }
                    )
                    .matchedGeometryEffect(id: viewModel.state.mainToken.id, in: namespace)
                    .onTapGesture {
                        if viewModel.state.checkBoxMode {
                            viewModel.trigger(.selectCell(mainTokenId))
                        }
                    }
                    
            }
        }
    }
    
    var gridView: some View {
        
        LazyVGrid(columns: columns,
                  spacing: 12) {
            ForEach(viewModel.state.filteredTokens) { token in
                Button(action: {
                    if viewModel.state.checkBoxMode {
                        viewModel.trigger(.selectCell(token.id))
                    } else {
                        withAnimation {
                            viewModel.trigger(.moveToken(token.id))
                            hideKeyboard()
                        }
                    }
                }, label: {
                    TokenCellView(service: viewModel.state.service,
                                  token: token,
                                  isMain: false,
                                  checkBoxMode: $viewModel.state.checkBoxMode,
                                  isSelected: viewModel.state.selectedTokens[token.id],
                                  refreshAction: {
                                      viewModel.trigger(.refreshTokens)
                                  }
                    )
                })
                .matchedGeometryEffect(id: token.id, in: namespace, isSource: false)
            }
            addTokenView.frame(minHeight: 100)
        }
    }
    
    var addTokenView: some View {
        viewModel.state.isSearching ?
            nil : NavigationLink(
                destination: NavigationLazyView(
                    QRGuideView(service: viewModel.state.service)
                ).environmentObject(navigationFlow),
                isActive: $navigationFlow.isActive,
                label: {
                    TokenAddCellView()
                }
                
            )
    }
    
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        let service = TokenService(StorageManager())
        MainView(service: service)
    }
    
}

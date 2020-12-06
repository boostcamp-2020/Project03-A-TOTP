//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI
import UniformTypeIdentifiers

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
                TokenCellView(service: viewModel.state.service,
                              token: token,
                              isMain: false,
                              checkBoxMode: $viewModel.state.checkBoxMode,
                              isSelected: viewModel.state.selectedTokens[token.id],
                              refreshAction: {
                                viewModel.trigger(.refreshTokens)
                              }
                )
                .onTapGesture {
                    if viewModel.state.checkBoxMode {
                        viewModel.trigger(.selectCell(token.id))
                    } else {
                        withAnimation {
                            viewModel.trigger(.moveToMain(token.id))
                            hideKeyboard()
                        }
                    }
                }
                .matchedGeometryEffect(id: token.id, in: namespace, isSource: false)
                .onDrag { () -> NSItemProvider in
                    viewModel.trigger(.startDragging(token))
                    return NSItemProvider()
                }
                .onDrop(of: [UTType.text],
                        delegate: TokenDropDelegate(
                            item: token,
                            tokenOnDrag: $viewModel.state.tokenOnDrag,
                            service: viewModel.state.service,
                            moveAction: { from, target in
                                viewModel.trigger(.move(from, target))
                            },
                            endAction: {
                                viewModel.trigger(.endDragging)
                            }
                        )
                )
                //.opacity(viewModel.state.tokenOnDrag == token ? 0.0 : 1.0)
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

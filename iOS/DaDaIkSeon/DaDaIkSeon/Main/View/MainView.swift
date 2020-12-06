//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI
import UniformTypeIdentifiers

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
    var tokenOnDrag: Token?
}

enum MainInput {
    case search(_ text: String)
    case startSearch
    case endSearch
    case showCheckBox
    case hideCheckBox
    case selectCell(_ id: UUID)
    case startSetting
    case endSetting
    case deleteSelectedTokens
    case refreshTokens
    case moveToMain(_ id: UUID)
    case move(_ from: Int, _ target: Int)
    case startDragging(_ token: Token)
    case endDragging
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

struct TokenDropDelegate: DropDelegate {
    
    private let item: Token
    @Binding private var tokenOnDrag: Token?
    private var service: TokenServiceable
    private var moveAction: (Int, Int) -> Void
    private var endAction: () -> Void
    private var listData: [Token] { service.tokenList() }
    
    init(item: Token,
         tokenOnDrag: Binding<Token?>,
         service: TokenServiceable,
         moveAction: @escaping (Int, Int) -> Void,
         endAction: @escaping () -> Void) {
        self.item = item
        self._tokenOnDrag = tokenOnDrag
        self.service = service
        self.moveAction = moveAction
        self.endAction = endAction
    }
    
    func dropEntered(info: DropInfo) {
        
        // item은 원래 위치, tokenOnDrag는 현재 드래그 중인 토큰의 위치
        if item != tokenOnDrag {
            guard let from = listData.firstIndex(where: {
                $0 == tokenOnDrag
            }) else { return }
            guard let target = listData.firstIndex(where: {
                $0 == item
            }) else { return }
            if listData[target].id != listData[from].id {
                moveAction(from, target)
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        endAction()
        return true
    }
}

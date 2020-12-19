//
//  ContentView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/24.
//

import SwiftUI
import UniformTypeIdentifiers

class MainLinkManager: ObservableObject {
    
    @Published var tag: Int? = nil
    
    func isThere(_ target: MainLinkTable) -> Bool {
        tag == scene(target)
    }
    
    func change(_ target: MainLinkTable) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tag = self.scene(target)
        }
    }
    
    func scene(_ target: MainLinkTable) -> Int? {
        switch target {
        case .main:
            return nil
        case .qrguide, .tokenEdit,
             .background, .pincode, .setting:
            return target.rawValue
        }
    }
    
    enum MainLinkTable: Int {
        case main = -1
        case qrguide = 0
        case tokenEdit = 1
        case background = 2
        case pincode = 3
        case setting = 4
    }
}

struct MainView: View {
    
    // MARK: ViewModel
    
    @StateObject var viewModel: AnyViewModel<MainState, MainInput>
    
    // MARK: Property
    
    @StateObject var linkManager: MainLinkManager
    @State var hasBackupPassword = false
    @Namespace var namespace
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    // MARK: Initialization
    
    init(service: TokenServiceable) {
        _viewModel = StateObject(wrappedValue: AnyViewModel(MainViewModel(service: service)))
        _linkManager = StateObject(wrappedValue: MainLinkManager())
    }
    
    // MARK: Body
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 12) {
                viewModel.state.isSearching ?
                    nil : HeaderView(viewModel: viewModel, linkManager: linkManager)
                    .padding(.top, 12)
                    .padding(.bottom, -6)
                if !viewModel.state.checkBoxMode {
                    SearchBarView(viewModel: viewModel)
                }
                ZStack {
                    ScrollView {
                        VStack(spacing: 12) {
                            mainCellView.frame(height: 200)
                                .padding(.horizontal, 12)
                                .padding(.top, 6)
                            gridView
                                .padding([.horizontal, .bottom], 12)
                        }
                    }
                    .navigationBarHidden(true)
                    
                    navigaionTable
                }
            }
            .onAppear(perform: {
                TOTPTimer.shared.startAll()
                viewModel.trigger(.commonInput(.refreshTokens))
            })
            .onDisappear(perform: {
                TOTPTimer.shared.cancel()
            })
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $hasBackupPassword, content: {
            BackupPasswordView(viewModel: AnyViewModel(
                                BackupPasswordViewModel(
                                    service: viewModel.state.service)))
        })
        .onChange(of: viewModel.state.hasBackupPassword, perform: { value in
            hasBackupPassword = value
        })
        .onTapGesture {
            hideKeyboard()
        }
        .onChange(of: scenePhase, perform: { newScenePhrase in
            switch newScenePhrase {
            case .inactive:
                if StorageManager<String>(type: .pincode).load() != nil {
                    if linkManager.isThere(.main) { // main이 아닐때는 발동 안되게!
                        DispatchQueue.main.async {
                            linkManager.change(.background)
                        }
                    }
                }
            case .active:
                if linkManager.isThere(.background) {
                    if nil != StorageManager<String>(type: .pincode).load() {
                        BiometricIDAuth().authenticateUser { result in
                            if result == nil { // 생체인증 성공
                                DispatchQueue.main.async {
                                    withAnimation {
                                        linkManager.change(.main)
                                    }
                                }
                            } else {            // 생체인증 실패
                                DispatchQueue.main.async {
                                    linkManager.change(.pincode)
                                }
                            }
                        }
                    } else {
                        withAnimation {
                            linkManager.change(.main)
                        }
                    }
                }
            default: break
            }
            
        })
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
                                            viewModel.trigger(.commonInput(.refreshTokens))
                                        }
                    )
                    .animation(nil)
                    .matchedGeometryEffect(id: viewModel.state.mainToken.id, in: namespace)
                    .onTapGesture {
                        if viewModel.state.checkBoxMode {
                            viewModel.trigger(.checkBoxInput(.selectCell((mainTokenId))))
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
                                viewModel.trigger(.commonInput(.refreshTokens))
                              }
                )
                .animation(.default)
                .onTapGesture {
                    if viewModel.state.checkBoxMode {
                        viewModel.trigger(.checkBoxInput(.selectCell(token.id)))
                    } else {
                        withAnimation {
                            viewModel.trigger(.cellInput(.moveToMain(token.id)))
                            hideKeyboard()
                        }
                    }
                }
                .matchedGeometryEffect(id: token.id, in: namespace, isSource: false)
                .onDrag { () -> NSItemProvider in
                    viewModel.trigger(.cellInput(.startDragging(token)))
                    return NSItemProvider()
                }
                .onDrop(of: [UTType.text],
                        delegate: TokenDropDelegate(
                            item: token,
                            tokenOnDrag: $viewModel.state.tokenOnDrag,
                            service: viewModel.state.service,
                            moveAction: { from, target in
                                viewModel.trigger(.cellInput(.move(from, target)))
                            },
                            endAction: {
                                viewModel.trigger(.cellInput(.endDragging))
                            }
                        )
                )
            }
            
            if !viewModel.state.checkBoxMode {
                addTokenView.frame(minHeight: 100)
            }
            
        }
    }
    
    var addTokenView: some View {
        viewModel.state.isSearching ? nil :
            ZStack {
                TokenAddCellView()
            }
            .onTapGesture {
                linkManager.change(.qrguide)
            }
    }
    
    // MARK: tag
    @State var qrCodeURL: String = ""
    @Environment(\.scenePhase) var scenePhase
    
    var navigaionTable: some View {
        Group {
            NavigationLink(
                "", destination: NavigationLazyView(
                    QRGuideView(
                        qrCodeURL: $qrCodeURL,
                        linkManager: linkManager)
                ),
                tag: linkManager.scene(.qrguide)!,
                selection: $linkManager.tag)
            NavigationLink(
                "", destination:
                    TokenEditView(
                        linkManager: ObservedObject(wrappedValue: linkManager),
                        service: viewModel.state.service,
                        token: nil,
                        qrCode: qrCodeURL,
                        refresh: {
                            viewModel.trigger(.commonInput(.refreshTokens))
                        }),
                tag: linkManager.scene(.tokenEdit)!,
                selection: $linkManager.tag)
            NavigationLink(
                "", destination: BackgroundView(),
                tag: linkManager.scene(.background)!,
                selection: $linkManager.tag)
                .transition(.move(edge: .bottom))
            if let password = StorageManager<String>(type: .pincode).load() {
                NavigationLink(
                    "", destination: PinCodeView(
                        mode: .auth(password),
                        completion: { _ in
                            linkManager.change(.main)
                        }),
                    tag: linkManager.scene(.pincode)!,
                    selection: $linkManager.tag)
            }
            NavigationLink(
                "", destination:
                    SettingView(linkManager: ObservedObject(wrappedValue: linkManager)),
                tag: linkManager.scene(.setting)!,
                selection: $linkManager.tag)
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        let service = TokenService(StorageManager(type: .token))
        MainView(service: service)
    }
    
}

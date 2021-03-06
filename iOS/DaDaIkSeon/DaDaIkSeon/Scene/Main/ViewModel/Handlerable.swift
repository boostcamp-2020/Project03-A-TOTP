//
//  Handlerable.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/06.
//

import Foundation

protocol Handlerable {
    func trigger()
}

class CommonHandler: Handlerable {
    
    private var input: CommonInput?
    @Published var state: MainState
    
    init(_ input: CommonInput? = nil, _ state: Published<MainState>) {
        self.input = input
        self._state = state
    }
    
    init(_ state: Published<MainState>) {
        self._state = state
    }
    
    func trigger() {
        guard let input = input else { return }
        switch input {
        case .refreshTokens:
            
            #if DEBUG
            
            if StorageManager<String>(type: .backupPassword).load() == nil {
                state.hasBackupPassword = true
                return
            }
            
            if isBackup() { // 네트워크 - 데이터를 받아서 최신걸로 저장
                state.service.refreshTokens { result in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        switch result {
                        case .successSync:
                            self.showMainScene()
                        case .successLoad:
                            self.showMainScene()
                        case .failedDecryption:
                            self.state.hasBackupPassword = true
                        default:
                            self.showMainScene()
                        }
                    }
                }
            } else {
                print("백업모드 아님")
            }
            #endif
            showMainScene()
        }
    }
    
    func showMainScene() {
        if state.service.tokenCount == 0 {
            state.zeroTokenState = true
            state.filteredTokens = []
        } else {
            if state.service.tokenCount >= 1 {
                state.zeroTokenState = false
            }
            if let maintoken = state.service.mainToken() {
                state.mainToken = maintoken
                state.filteredTokens = excludeMainCell()
                return
            }
        }
    }
    
    func excludeMainCell() -> [Token] {
        state.service.excludeMainCell()
    }
    
    func endSearch() {
        state.isSearching = false
    }
    
    // error 처리 해야됨 throws
    func isBackup() -> Bool {
        if let user = DDISUserCache.get() {
            return user.device?.backup ?? false
        } else {
            print("유저 정보 불러오기 실패")
            return false
        }
    }
    
}

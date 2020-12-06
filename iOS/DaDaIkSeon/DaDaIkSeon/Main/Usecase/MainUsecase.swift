//
//  MainUsecase.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/06.
//

import Foundation

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
//
//enum SearchInput {
//    case search(_ text: String)
//    case startSearch
//    case endSearch
//}

enum MainInput {
    // searchInput
    case search(_ text: String)
    case startSearch
    case endSearch
    
    // checkBoxInput
    case showCheckBox
    case hideCheckBox
    case deleteSelectedTokens
    
    // cellInput
    case selectCell(_ id: UUID)
    case moveToMain(_ id: UUID)
    case move(_ from: Int, _ target: Int)
    case startDragging(_ token: Token)
    case endDragging
    
    // settingInput
    case startSetting
    case endSetting
    
    // mainInput
    case refreshTokens
}

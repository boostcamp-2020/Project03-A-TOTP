//
//  MainUsecase.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/06.
//

import Foundation

// MARK: State

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

// MARK: Input

enum MainInput {
    case searchInput(_ input: SearchInput)
    case checkBoxInput(_ input: CheckBoxInput)
    case cellInput(_ input: CellInput)
    case settingInput(_ input: SettingInput)
    case commonInput(_ input: CommonInput)
}

enum CommonInput {
    case refreshTokens
}

enum SearchInput {
    case search(_ text: String)
    case startSearch
    case endSearch
}

enum CheckBoxInput {
    case showCheckBox
    case hideCheckBox
    case selectCell(_ id: UUID)
    case deleteSelectedTokens
}

enum CellInput {
    case moveToMain(_ id: UUID)
    case move(_ from: Int, _ target: Int)
    case startDragging(_ token: Token)
    case endDragging
}

enum SettingInput {
    case startSetting
    case endSetting
}

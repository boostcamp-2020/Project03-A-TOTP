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
    var selectedTokens: [String: Bool]
    var selectedCount: Int
    var zeroTokenState: Bool
    var tokenOnDrag: Token?
    var hasBackupPassword: Bool
}

// MARK: Input

enum MainInput {
    case searchInput(_ input: SearchInput)
    case checkBoxInput(_ input: CheckBoxInput)
    case cellInput(_ input: CellInput)
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
    case selectCell(_ id: String)
    case deleteSelectedTokens
}

enum CellInput {
    case moveToMain(_ id: String)
    case move(_ from: Int, _ target: Int)
    case startDragging(_ token: Token)
    case endDragging
}

//
//  MainServiceable.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/29.
//

import Foundation

protocol MainServiceable {
    func loadTokens() -> [Token]
    func getFilteredTokens(text: String) -> [Token]
}

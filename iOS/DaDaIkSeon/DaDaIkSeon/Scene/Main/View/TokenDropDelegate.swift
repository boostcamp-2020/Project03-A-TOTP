//
//  TokenDropDelegate.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/06.
//

import SwiftUI

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

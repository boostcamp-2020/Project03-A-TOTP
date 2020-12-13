//
//  Entry.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/13.
//

import Foundation

class Entry: ObservableObject {
    
    var characterLimit: Int
    
    init(limit: Int) {
        characterLimit = limit
    }
    
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    
}

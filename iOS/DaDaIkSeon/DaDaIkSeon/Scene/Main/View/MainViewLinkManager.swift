//
//  MainViewLinkManager.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/19.
//

import Foundation

class MainLinkManager: ObservableObject {
    
    @Published var tag: Int? = nil // nil을 지정해야 처음 메인뷰에서도 inactive 코드가 동작한다.
    
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

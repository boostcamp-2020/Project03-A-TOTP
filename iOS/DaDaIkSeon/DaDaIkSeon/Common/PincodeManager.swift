////
////  PincodeManager.swift
////  DaDaIkSeon
////
////  Created by 정재명 on 2020/12/11.
////
//
//import Foundation
//
//final class PincodeManager {
//    // MARK: Keychain
//    
//    private let account = "Pincode"
//    private let service = Bundle.main.bundleIdentifier
//    
//    private lazy var query: [CFString: Any]? = {
//        guard let service = service else { return nil }
//        return [kSecClass: kSecClassGenericPassword,
//                kSecAttrService: service,
//                kSecAttrAccount: account]
//    }()
//    
//    @discardableResult
//    func storePincode(_ pincode: String) -> Bool {
//        guard let data = try? JSONEncoder().encode(pincode),
//              let service = service else { return false }
//        
//        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
//                                      kSecAttrService: service,
//                                      kSecAttrAccount: account,
//                                      kSecAttrGeneric: data]
//        deletePincode()
//        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
//    }
//    
//    func loadPincode() -> String? {
//        guard let service = service else { return nil }
//        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
//                                      kSecAttrService: service,
//                                      kSecAttrAccount: account,
//                                      kSecMatchLimit: kSecMatchLimitOne,
//                                      kSecReturnAttributes: true,
//                                      kSecReturnData: true]
//        
//        var item: CFTypeRef?
//        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }
//        
//        guard let existingItem = item as? [String: Any],
//              let data = existingItem[kSecAttrGeneric as String] as? Data,
//              let pincode = try? JSONDecoder().decode(String.self, from: data) else { return nil }
//        
//        return pincode
//    }
//    
//    @discardableResult
//    func deletePincode() -> Bool {
//        guard let query = query else { return false }
//        return SecItemDelete(query as CFDictionary) == errSecSuccess
//    }
//}

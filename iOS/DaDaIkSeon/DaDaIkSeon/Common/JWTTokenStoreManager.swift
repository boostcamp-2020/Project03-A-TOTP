////
////  JWTTokenStoreManager.swift
////  DaDaIkSeon
////
////  Created by 양어진 on 2020/12/13.
////
//
//import Foundation
//
//final class JWTTokenStoreManager {
//
//    // MARK: Keychain
//
//    private let account = "JWTToken"
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
//    func store(_ jwtToken: String) -> Bool {
//        guard let data = try? JSONEncoder().encode(jwtToken),
//              let service = service else { return false }
//
//        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
//                                      kSecAttrService: service,
//                                      kSecAttrAccount: account,
//                                      kSecAttrGeneric: data]
//        delete()
//        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
//    }
//
//    func load() -> String? {
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
//              let jwtToken = try? JSONDecoder().decode(String.self, from: data) else { return nil }
//
//        return jwtToken
//    }
//
//    @discardableResult
//    func delete() -> Bool {
//        guard let query = query else { return false }
//        return SecItemDelete(query as CFDictionary) == errSecSuccess
//    }
//}

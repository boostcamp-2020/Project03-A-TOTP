//
//  StorageManager.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/05.
//

import Foundation
import Security

final class StorageManager {
    
    // MARK: Keychain
    
    private let account = "TokenService"
    private let service = Bundle.main.bundleIdentifier
    
    private lazy var query: [CFString: Any]? = {
        guard let service = service else { return nil }
        return [kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account]
    }()
    
    func storeTokens(_ tokens: [Token]) -> Bool {
        guard let data = try? JSONEncoder().encode(tokens),
              let service = service else { return false }
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service,
                                      kSecAttrAccount: account,
                                      kSecAttrGeneric: data]
        _ = deleteTokens()
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    func loadTokens() -> [Token]? {
        guard let service = service else { return nil }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service,
                                      kSecAttrAccount: account,
                                      kSecMatchLimit: kSecMatchLimitOne,
                                      kSecReturnAttributes: true,
                                      kSecReturnData: true]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }
        
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecAttrGeneric as String] as? Data,
              let tokens = try? JSONDecoder().decode([Token].self, from: data) else { return nil }
        
        return tokens
    }
    
    func deleteTokens() -> Bool {
        guard let query = query else { return false }
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
    
}

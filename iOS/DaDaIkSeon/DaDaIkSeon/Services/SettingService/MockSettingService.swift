//
//  SettingService.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/08.
//

import Foundation

class MockSettingService: SettingServiceable {
    
    private var user = DDISUser.dummy() // 나중에 userDefault로 변경해야함
    private var pincodeManager = PincodeManager()
    
    init() {
        loadUser()
    }

    private func loadUser() { // 유저 디폴트에서 가져와야한다.
        user = DDISUser.dummy()
    }
    
    func refresh() {
        // 네트워크에서 가져오기
    }
    
    func readEmail() -> String? {
        return user.email
    }
    
    func updateEmail(_ email: String) {
        user.email = email
    }
    
    func updateBackupMode() {
        self.user.backup?.toggle()
    }
    
    func updateBackupPassword(_ password: String) {
        // 백업 패스워드는 User 구조체에 들어가지 않는다.
        // 따로 UserDefault로 읽고 쓰고 변경해야 한다.
        // 나중에 토큰 가져올 때 이 비밀번호를 사용하여 복호화하게 된다.
    }
    
    func updateMultiDeviceMode() {
        self.user.multiDevice?.toggle()
    }
    
    func readDevice() -> [Device]? {
        user.device
    }
    
    func updateDevice(_ newDevice: Device) {
        guard let devices = user.device else { return }
        if let index = devices.firstIndex(where: { newDevice.udid == $0.udid }) {
            user.device?[index] = newDevice
        }
    }
    
    func deleteDevice(_ udid: String) {
        user.device?.removeAll(where: {
            $0.udid == udid
        })
    }
    
    var pincode: String? {
        pincodeManager.loadPincode()
    }
}

final class PincodeManager {
    // MARK: Keychain
    
    private let account = "Pincode"
    private let service = Bundle.main.bundleIdentifier
    
    private lazy var query: [CFString: Any]? = {
        guard let service = service else { return nil }
        return [kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account]
    }()
    
    func storePincode(_ tokens: String) -> Bool {
        guard let data = try? JSONEncoder().encode(tokens),
              let service = service else { return false }
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service,
                                      kSecAttrAccount: account,
                                      kSecAttrGeneric: data]
        _ = deletePincode()
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    func loadPincode() -> String? {
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
              let pincode = try? JSONDecoder().decode(String.self, from: data) else { return nil }
        
        return pincode
    }
    
    func deletePincode() -> Bool {
        guard let query = query else { return false }
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
}

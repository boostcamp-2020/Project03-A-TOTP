//
//  SettingNetworkManager.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/11.
//

import Foundation

final class SettingNetworkManager: Requestable {
    
    typealias NetworkData = ResponseObject<String>
    
    static let shared = SettingNetworkManager()
    private init() {}
    
    func changeEmail(email: String,
                     completion: @escaping (SettingNetworkResult) -> Void) {
        let settingEndpoint: SettingEndpoint = .patchEmail(email: email)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                switch data.responseCode {
                case (200..<300):
                    completion(.emailEdit)
                default:
                    completion(.ETCError)
                }
            case .networkError:
                completion(.dataParsingError)
            case .networkFail:
                completion(.networkError)
            }
        }
    }
    
    func changeBackupMode(udid: String,
                          backup: Bool,
                          completion: @escaping (SettingNetworkResult) -> Void) {
        
        let settingEndpoint: SettingEndpoint = .patchBackup(udid: udid,
                                                            isBackup: backup)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                switch data.responseCode {
                case (200..<300):
                    completion(.backupToggle)
                default:
                    completion(.ETCError)
                }
            case .networkError:
                completion(.dataParsingError)
            case .networkFail:
                completion(.networkError)
            }
        }
    }
    
    func changeMultiDevice(multiDevice: Bool,
                           completion: @escaping (SettingNetworkResult) -> Void) {
        
        let settingEndpoint: SettingEndpoint = .patchMultiDevice(isMultiDevice: multiDevice)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                switch data.responseCode {
                case (200..<300):
                    completion(.multiDeviceToggle)
                default:
                    completion(.ETCError)
                }
            case .networkError:
                completion(.dataParsingError)
            case .networkFail:
                completion(.networkError)
            }
        }
    }
    
    func changeDevice(udid: String,
                      name: String,
                      completion: @escaping (SettingNetworkResult) -> Void) {
        let settingEndpoint: SettingEndpoint = .patchDevice(udid: udid, name: name)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                switch data.responseCode {
                case (200..<300):
                    completion(.deviceNameEdit)
                default:
                    completion(.ETCError)
                }
            case .networkError:
                completion(.dataParsingError)
            case .networkFail:
                completion(.networkError)
            }
        }
    }
    
    func deleteDevice(udid: String,
                      completion: @escaping (SettingNetworkResult) -> Void) {
        
        let settingEndpoint: SettingEndpoint = .deleteDevice(udid: udid)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                switch data.responseCode {
                case (200..<300):
                    completion(.deviceDelete)
                default:
                    completion(.ETCError)
                }
            case .networkError:
                completion(.dataParsingError)
            case .networkFail:
                completion(.networkError)
            }
        }
    }
    
}

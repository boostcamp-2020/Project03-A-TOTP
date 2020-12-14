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
                     completion: @escaping () -> Void) {
        
        let settingEndpoint: SettingEndpoint = .patchEmail(email: email)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess:
                completion()
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
            }
        }
    }
    
    func changeBackupMode(udid: String,
                          backup: Bool,
                          completion: @escaping (DataResultType<String>) -> Void) {
        
        let settingEndpoint: SettingEndpoint = .patchBackup(udid: udid,
                                                            isBackup: backup)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
//                guard let resultData = data.responseResult.data else {
//                    completion(.messageError)
//                    return
//                }
                //completion(.result(resultData))
                completion(.result(""))
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
//                guard let resultData = data.responseResult.data else {
//                    completion(.messageError)
//                    return
//                }
//                completion(.result(resultData))
                completion(.result(""))
            case .networkError:
                completion(.dataParsingError)
            case .networkFail:
                completion(.networkError)
            }
        }
    }
    
    func changeDevice(udid: String,
                      name: String,
                      completion: @escaping () -> Void) {
        
        let settingEndpoint: SettingEndpoint = .patchDevice(udid: udid, name: name)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess:
                completion()
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
            }
        }
    }
    
    func deleteDevice(udid: String,
                      completion: @escaping () -> Void) {
        
        let settingEndpoint: SettingEndpoint = .deleteDevice(udid: udid)
        request(settingEndpoint) { result in
            switch result {
            case .networkSuccess:
                completion()
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
            }
        }
    }
    
}

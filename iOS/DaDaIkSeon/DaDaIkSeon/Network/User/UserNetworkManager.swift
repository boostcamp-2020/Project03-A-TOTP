//
//  UserNetworkManager.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

final class UserNetworkManager: Requestable {
    
    typealias NetworkData = ResponseObject<DDISUser>
    
    private var userEndpoint: UserEndpoint = .get
    
    static let shared = UserNetworkManager()
    private init() {}
    
    func load(completion: @escaping (SettingNetworkResult) -> Void) {
        userEndpoint = .get
        request(userEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                switch data.responseCode {
                case (200..<300):
                    guard let user = data.responseResult.data else {
                        completion(.dataParsingError)
                        return
                    }
                    completion(.refresh(user))
                case (400..<500):
                    completion(.accessError403)
                case 500:
                    completion(.ETCError500)
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
    
    func sendEmail(email: String,
                   device: Device,
                   completion: @escaping (LoginNetworkResult) -> Void) {
        
        userEndpoint = .postEmail(email: email, device: device)
        request(userEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                switch data.responseCode {
                case 200..<300:
                    completion(.successSendEmail)
                default:
                    completion(.multideviceOff)
                }
            case .networkError:
                completion(.dataParsingError)
            case .networkFail:
                completion(.networkError)
            }
        }
    }

}

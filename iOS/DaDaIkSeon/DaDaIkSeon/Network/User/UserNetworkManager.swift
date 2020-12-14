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
    
    func load(completion: @escaping (DDISUser) -> Void) {
        userEndpoint = .get
        request(userEndpoint) { result in
            switch result {
            case .networkSuccess(let data):
                guard let user = data.responseResult.data else { return }
                completion(user)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail!!!!")
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

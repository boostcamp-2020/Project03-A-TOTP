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
                   completion: @escaping () -> Void) {
        
        userEndpoint = .postEmail(email: email)
        request(userEndpoint) { result in
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

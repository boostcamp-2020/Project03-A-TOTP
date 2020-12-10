//
//  UserNetworkManager.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/10.
//

import Foundation

final class UserNetworkManager: Requestable {
    
    typealias NetworkData = ResponseObject<DDISUser>
    
    static let shared = UserNetworkManager()
    private init() {}
    
    var userEndpoint: UserEndpoint = .get
    
    func loadUser(completion: @escaping (DDISUser) -> Void) {
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

}

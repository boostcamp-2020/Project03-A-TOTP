//
//  Requestable.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

import Foundation

protocol Requestable {
    associatedtype NetworkData: Codable
    typealias NetworkSuccessResult = (responseCode: Int,
                                      responseResult: NetworkData)
    
    func request(_ endpoint: EndpointType,
                 completion: @escaping (NetworkResult<NetworkSuccessResult>) -> Void)
}

extension Requestable {
    func request(_ endpoint: EndpointType,
                 completion: @escaping (NetworkResult<NetworkSuccessResult>) -> Void) {
        
        guard let url = URL(string: endpoint.path) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let params = endpoint.params {
            let jsonData = try? JSONSerialization.data(withJSONObject: params)
            let headers = [
                "Content-Type": "application/json",
                // 토큰 등등
                "Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJkZXZpY2VVZGlkIjoidWRpZHVkaWQiLCJpYXQiOjE2MDc2OTM1OTF9.dkRJ6vC92c6UIjb03sZIwyBKERRpZSbcUKGfXJNNf1s"
                // \(UserDefaults.standard.string(forKey: "token") 로 바꿔야 한다.
            ]
            
            request.httpBody = jsonData
            request.allHTTPHeaderFields = headers
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse else { return }
            let responseCode = response.statusCode
            
            if error != nil {
                completion(.networkFail)
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let datas = try decoder.decode(NetworkData.self,
                                               from: data)
                let result: NetworkSuccessResult = (responseCode,
                                                    datas)
                completion(.networkSuccess(result))
            } catch {
                completion(.networkError((responseCode,
                                          error.localizedDescription)))
            }
        }.resume()
    }
}

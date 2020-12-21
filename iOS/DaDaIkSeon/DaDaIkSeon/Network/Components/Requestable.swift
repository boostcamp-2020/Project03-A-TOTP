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
            request.httpBody = jsonData
        }
        
        var headers: [String: String] = ["Content-Type": "application/json"]
        if let jwtToken = StorageManager<String>(type: .JWTToken).load() {
            headers["Authorization"] = "bearer \(jwtToken)"
        }
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse else { return }
            let responseCode = response.statusCode
            
            print("주소 : \(url), \(request.httpMethod)")
            print("디바이스 수정된시간 \(DDISUserCache.get()?.device?.lastUpdate)")
            print(String(data: data, encoding: .utf8))
            
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

//
//  NetworkResult.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/08.
//

enum NetworkResult<T> {
    case networkSuccess(T)
    case networkError((responseCode: Int, message: String))
    case networkFail
}

enum DataResultType<T>: Error {
    case result1(T, Int)
    
    case messageError
    case networkError
    case dataParsingError
}

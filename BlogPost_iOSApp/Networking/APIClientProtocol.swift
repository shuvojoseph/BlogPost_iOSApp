//
//  APIClientProtocol.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 29/9/25.
//

import Alamofire

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint,
                               method: HTTPMethod?,
                               parameters: Parameters?,
                               encoding: ParameterEncoding,
                               headers: HTTPHeaders?,
                               completion: @escaping (Result<T, AFError>) -> Void)
}

extension APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint,
                               method: HTTPMethod? = nil,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = JSONEncoding.default,
                               headers: HTTPHeaders? = nil,
                               completion: @escaping (Result<T, AFError>) -> Void) {
        // Forward to the real implementation
        request(endpoint,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers,
                completion: completion)
    }
}

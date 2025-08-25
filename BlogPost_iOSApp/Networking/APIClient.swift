//
//  APIClient.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation
import Alamofire


final class APIClient {
    static let shared = APIClient()
    private let baseURL: String
    
    
    private init() {
        self.baseURL = AppConfig.baseURLString
    }
    
    
    func request<T: Decodable>(_ endpoint: Endpoint,
                               method: HTTPMethod? = nil,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = JSONEncoding.default,
                               headers: HTTPHeaders? = nil,
                               completion: @escaping (Result<T, AFError>) -> Void) {
        
        let url = baseURL + endpoint.path
        print("url : "+url)
        // Convert the string method to Alamofire's HTTPMethod
        let requestMethod: Alamofire.HTTPMethod = {
            if let method = method {
                return method
            } else {
                // Convert our endpoint.method string to Alamofire's HTTPMethod
                switch endpoint.method.uppercased() {
                case "GET": return .get
                case "POST": return .post
                case "PUT": return .put
                case "DELETE": return .delete
                case "PATCH": return .patch
                case "HEAD": return .head
                case "OPTIONS": return .options
                default: return .get // Default fallback
                }
            }
        }()
        
        AF.request(url,
                   method: requestMethod,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
        .validate()
        .responseDecodable(of: T.self) { response in
            print("response.description : " + response.description)
            completion(response.result)
        }
        /*
         AF.request(url,
         method: method ?? HTTPMethod(rawValue: endpoint.method),
         parameters: parameters,
         encoding: encoding,
         headers: headers)
         .validate()
         .responseDecodable(of: T.self) { response in
         completion(response.result)
         }*/
    }
}

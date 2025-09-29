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
            //print("response.description : " + response.description)
            // Print the HTTP status code
            print("HTTP Status Code: \(response.response?.statusCode ?? -1)")
            
            // Print the raw response data as string
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                print("Raw Response: \(responseString)")
            } else {
                print("No response data or unable to convert to string")
            }
            
            // Print headers
            print("Response Headers: \(response.response?.allHeaderFields ?? [:])")
            
            // Print detailed error information
            switch response.result {
            case .success(let decodedObject):
                print("Success: \(decodedObject)")
                completion(.success(decodedObject))
                
            case .failure(let error):
                print("=== ALAMOFIRE ERROR DETAILS ===")
                print("Error: \(error)")
                print("Error Localized Description: \(error.localizedDescription)")
                
                // Get the underlying error
                if let underlyingError = error.underlyingError {
                    print("Underlying Error: \(underlyingError)")
                    print("Underlying Error Localized: \(underlyingError.localizedDescription)")
                }
                
                // Check if it's a response validation error
                if let afError = error.asAFError {
                    switch afError {
                    case .responseValidationFailed(let reason):
                        print("Response Validation Failed: \(reason)")
                        switch reason {
                        case .unacceptableStatusCode(let code):
                            print("Status Code: \(code)")
                        case .customValidationFailed(let error):
                            print("Custom Validation Failed: \(error)")
                        default:
                            break
                        }
                        
                    case .responseSerializationFailed(let reason):
                        print("Response Serialization Failed: \(reason)")
                        
                    case .multipartEncodingFailed(let reason):
                        print("Multipart Encoding Failed: \(reason)")
                        
                    case .parameterEncodingFailed(let reason):
                        print("Parameter Encoding Failed: \(reason)")
                        
                    case .sessionInvalidated(let error):
                        print("Session Invalidated: \(error?.localizedDescription ?? "No error")")
                        
                    default:
                        print("Other AFError: \(afError)")
                    }
                }
                
                // Print the raw data that caused decoding failure
                if case let .responseSerializationFailed(reason) = error.asAFError,
                   case .decodingFailed(let decodingError) = reason {
                    print("Decoding Error: \(decodingError)")
                    if let data = response.data {
                        print("Problematic Data (as string): \(String(data: data, encoding: .utf8) ?? "Cannot convert to string")")
                    }
                }
                print("=================================")
            }
        }
    }
}

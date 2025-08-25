//
//  APIError.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation


enum APIError: Error, LocalizedError {
    case invalidURL
    case decoding
    case server(String)
    case unauthorized
    case unknown
    
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .decoding: return "Failed to decode the response"
        case .server(let msg): return msg
        case .unauthorized: return "Unauthorized"
        case .unknown: return "Unknown error"
        }
    }
}

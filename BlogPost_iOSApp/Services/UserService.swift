//
//  UserService.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 26/8/25.
//
import Foundation
import Alamofire

final class UserService {
    static let shared = UserService()
    
    func fetchUsers(completion: @escaping (Result<[User], AFError>) -> Void) {
        print("fetchUsers() called")
        guard let token = AuthManager.shared.accessToken else {
            print("No JWT token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        print("headers :" + headers.description)
        APIClient.shared.request(.users, headers: headers, completion: completion)
    }
}

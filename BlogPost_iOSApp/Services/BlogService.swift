//
//  BlogService.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation
import Alamofire


final class BlogService {
    static let shared = BlogService()
    
    
    func fetchBlogs(completion: @escaping (Result<[Blog], AFError>) -> Void) {
        APIClient.shared.request(.blogs, completion: completion)
    }
    
    
    func fetchBlog(id: String, completion: @escaping (Result<Blog, AFError>) -> Void) {
        APIClient.shared.request(.blog(id: id), completion: completion)
    }
    
    private func authHeaders() -> HTTPHeaders? {
            guard let token = AuthManager.shared.accessToken else { return nil }
            var headers = HTTPHeaders()
            headers.add(name: "Authorization", value: "Bearer \(token)")
            return headers
        }
    
    // Create - now accepts details and coOwnerIds
    func createBlog(title: String, details: String, coOwnerIds: [String], completion: @escaping (Result<Blog, AFError>) -> Void) {
        let params: Parameters = [
            "title": title,
            "details": details,
            "coOwnerIds": coOwnerIds
        ]
        // endpoint .blogs (POST)
        APIClient.shared.request(.blogs, method: .post, parameters: params, headers: authHeaders(), completion: completion)
    }
    
    // Update - now accepts details and coOwnerIds
    func updateBlog(id: String, title: String, details: String, coOwnerIds: [String], completion: @escaping (Result<Blog, AFError>) -> Void) {
        let params: Parameters = [
            "title": title,
            "details": details,
            "coOwnerIds": coOwnerIds
        ]
        APIClient.shared.request(.updateBlog(id: id), method: .put, parameters: params, headers: authHeaders(), completion: completion)
    }
    
    func deleteBlog(id: String, completion: @escaping (Result<VoidResponse, AFError>) -> Void) {
        APIClient.shared.request(.deleteBlog(id: id), headers: authHeaders(), completion: completion)
    }
}


struct VoidResponse: Decodable {}

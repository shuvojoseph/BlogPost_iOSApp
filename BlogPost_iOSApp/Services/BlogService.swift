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
    
    
    func createBlog(title: String, content: String, completion: @escaping (Result<Blog, AFError>) -> Void) {
        let params: Parameters = ["title": title, "content": content]
        APIClient.shared.request(.createBlog, parameters: params, completion: completion)
    }
    
    
    func updateBlog(id: String, title: String, content: String, completion: @escaping (Result<Blog, AFError>) -> Void) {
        let params: Parameters = ["title": title, "content": content]
        APIClient.shared.request(.updateBlog(id: id), parameters: params, completion: completion)
    }
    
    
    func deleteBlog(id: String, completion: @escaping (Result<VoidResponse, AFError>) -> Void) {
        APIClient.shared.request(.deleteBlog(id: id), completion: completion)
    }
}


struct VoidResponse: Decodable {}

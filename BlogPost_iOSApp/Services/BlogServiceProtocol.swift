//
//  BlogServiceProtocol.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 29/9/25.
//

import Alamofire

protocol BlogServiceProtocol {
    func fetchBlogs(completion: @escaping (Result<[Blog], AFError>) -> Void)
        func fetchBlog(id: String, completion: @escaping (Result<Blog, AFError>) -> Void)
        func createBlog(
            title: String,
            details: String,
            coOwnerIds: [String],
            completion: @escaping (Result<Blog, AFError>) -> Void
        )
        func updateBlog(
            id: String,
            title: String,
            details: String,
            coOwnerIds: [String],
            completion: @escaping (Result<Blog, AFError>) -> Void
        )
        func deleteBlog(id: String, completion: @escaping (Result<VoidResponse, AFError>) -> Void)
}

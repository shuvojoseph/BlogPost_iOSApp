//
//  BlogDetailViewModel.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation


final class BlogDetailViewModel: ObservableObject {
    @Published var blog: Blog?
    @Published var isLoading = false
    private let blogService: BlogServiceProtocol
    
    // Inject the service
    init(blogService: BlogServiceProtocol) {
        self.blogService = blogService
    }
    
    func loadBlog(id: String) {
        isLoading = true
        blogService.fetchBlog(id: id) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                if case .success(let blog) = result {
                    self.blog = blog
                }
            }
        }
    }
}

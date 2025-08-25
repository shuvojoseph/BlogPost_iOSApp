//
//  BlogListViewModel.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation


final class BlogListViewModel: ObservableObject {
    @Published var blogs: [Blog] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    func loadBlogs() {
        isLoading = true
        BlogService.shared.fetchBlogs { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let blogs):
                    self.blogs = blogs
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

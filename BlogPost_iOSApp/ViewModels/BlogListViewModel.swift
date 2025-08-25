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
    /*
    func deleteBlog(blog:Blog)
    {
        
    }
     */
    func deleteBlog(_ blog: Blog) {
        BlogService.shared.deleteBlog(id: blog.id) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success:
                    self.blogs.removeAll { $0.id == blog.id }
                case .failure(let err):
                    self.errorMessage = err.localizedDescription
                }
            }
        }
    }
    
    func isOwner(_ blog: Blog, currentUserId: String?) -> Bool {
        guard let uid = currentUserId else { return false }
        return blog.ownerId == uid   // adjust if your model uses a different field name
    }
}

//
//  BlogListViewModel.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation
import Combine

final class BlogListViewModel: ObservableObject {
    @Published var blogs: [Blog] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // Authentication / ownership state
    @Published var currentUserEmail: String? = nil
    @Published var isLoggedIn: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Subscribe to AuthManager changes AFTER all properties are initialized
        AuthManager.shared.$isLoggedIn
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoggedIn, on: self)
            .store(in: &cancellables)
        
        AuthManager.shared.$currentUserEmail
            .receive(on: DispatchQueue.main)
            .assign(to: \.currentUserEmail, on: self)
            .store(in: &cancellables)
    }

    // MARK: - Public API

    func loadBlogs() {
        //print("loadBlogs() called.")
        //print("isLoggedIn : " + isLoggedIn.description)
        isLoading = true
        BlogService.shared.fetchBlogs { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let items):
                    self.blogs = items
                case .failure(let err):
                    self.errorMessage = err.localizedDescription
                }
            }
        }
    }

    func deleteBlog(_ blog: Blog) {
        BlogService.shared.deleteBlog(id: blog.id) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success:
                    self.blogs.removeAll { $0.id == blog.id }
                case .failure(let err):
                    self.errorMessage = err.localizedDescription
                }
            }
        }
    }

    /// Add or update a blog locally (used after add/edit)
    func refreshBlogs(with blog: Blog) {
        if let idx = blogs.firstIndex(where: { $0.id == blog.id }) {
            blogs[idx] = blog
        } else {
            blogs.insert(blog, at: 0)
        }
    }

    /// Returns true if the logged-in email is one of the blog owners
    func isOwnedOrCoOwned(blog: Blog) -> Bool {
        return blog.canEdit(loggedInEmail: currentUserEmail)
    }

    // MARK: - Auth helpers used by the View

    /// Logout the current user (clears Keychain/UserDefaults and local state)
    func logout() {
        AuthManager.shared.logout()
    }
}

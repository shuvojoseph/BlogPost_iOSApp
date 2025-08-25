//
//  BlogFormViewModel.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation


final class BlogFormViewModel: ObservableObject {
    @Published var title = ""
    @Published var content = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    func createBlog(completion: @escaping (Bool) -> Void) {
        isLoading = true
        BlogService.shared.createBlog(title: title, content: content) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    completion(true)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}

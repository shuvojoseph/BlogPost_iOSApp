//
//  UsersSelectionViewModel.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 26/8/25.
//

import Foundation
//import Combine
import Alamofire

@MainActor
class UsersSelectionViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    private let userService = UserService.shared
    
    func loadUsers() {
        isLoading = true
        userService.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    print("loadUsers() success")
                    self?.users = users
                case .failure(let error):
                    print("Failed to load users: \(error)")
                }
                self?.isLoading = false
            }
        }
    }
}

//
//  RegisterViewModel.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation
import Alamofire

import Foundation
import Alamofire


final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    func register(completion: @escaping (Bool) -> Void) {
        isLoading = true
        let params: Parameters = ["email": email, "password": password]
        
        
        APIClient.shared.request(.register, parameters: params) { (result: Result<AuthTokens, AFError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    KeychainHelper.shared.save(response.token, service: "accessToken", account: "user")
                    completion(true)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}

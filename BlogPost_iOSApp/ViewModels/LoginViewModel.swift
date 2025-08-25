//
//  LoginViewModel.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation
import Alamofire


final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    func login(completion: @escaping (Bool) -> Void) {
        isLoading = true
        let params: Parameters = ["email": email, "password": password]
        
        
        APIClient.shared.request(.login, parameters: params) { (result: Result<AuthTokens, AFError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    KeychainHelper.shared.save(response.token, service: "accessToken", account: "user")
                    KeychainHelper.shared.save(response.refreshToken, service: "refreshToken", account: "user")
                    completion(true)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}

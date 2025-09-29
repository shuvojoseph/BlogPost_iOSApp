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
    
    @Published var isLoading = false
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String?
    
    func register(completion: @escaping (Bool) -> Void) {
        isLoading = true
        let params: Parameters = ["email": email, "password": password, "firstName":firstName,"lastName":lastName]
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
                    errorMessage = "All fields are required"
                    completion(false)
                    return
                }
        
        guard password == confirmPassword else {
                    errorMessage = "Passwords do not match"
                    completion(false)
                    return
                }
        
        APIClient.shared.request(.register, parameters: params) { (result: Result<Register, AFError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    print("Registration Successful :" + response.message)
                    completion(true)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}

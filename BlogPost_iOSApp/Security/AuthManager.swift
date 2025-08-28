//
//  AuthManager.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 26/8/25.
//

import Foundation

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isLoggedIn: Bool = false
    var accessToken: String?
    @Published var currentUserEmail: String?

    private init() {
        // restore login state from storage
        if let email = UserDefaults.standard.string(forKey: "currentUserEmail"),
                   let tokenData = KeychainHelper.shared.get(service: "auth", account: "accessToken"),
                   let token = String(data: tokenData, encoding: .utf8) {
                    self.currentUserEmail = email
                    self.accessToken = token
                    self.isLoggedIn = true
                }
    }
    
    func saveLogin(email: String, token: String) {
        self.currentUserEmail = email
        self.accessToken = token
        KeychainHelper.shared.save(token, service: "auth", account: "accessToken")
        UserDefaults.standard.set(email, forKey: "currentUserEmail")
        self.isLoggedIn = true
    }
    
    func logout() {
        self.currentUserEmail = nil
        self.accessToken = nil
        self.isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
        KeychainHelper.shared.remove(service: "auth", account: "accessToken")
    }
    
    /*
    var accessToken: String? {
        KeychainHelper.shared.get(service: "auth", account: "accessToken")
            .flatMap { String(data: $0, encoding: .utf8) }
    }

    var currentUserEmail: String? {
        UserDefaults.standard.string(forKey: "currentUserEmail")
    }
     */
    /*
    func saveLogin(email: String, token: String) {
        print("email :" + email)
        KeychainHelper.shared.save(token, service: "auth", account: "accessToken")
        UserDefaults.standard.set(email, forKey: "currentUserEmail")
    }

    func logout() {
        KeychainHelper.shared.remove(service: "auth", account: "accessToken")
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
    }
     */
}

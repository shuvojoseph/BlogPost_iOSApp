//
//  AuthManager.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 26/8/25.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    private init() {}

    var accessToken: String? {
        KeychainHelper.shared.get(service: "auth", account: "accessToken")
            .flatMap { String(data: $0, encoding: .utf8) }
    }

    var currentUserEmail: String? {
        UserDefaults.standard.string(forKey: "currentUserEmail")
    }

    func saveLogin(email: String, token: String) {
        print("email :" + email)
        KeychainHelper.shared.save(token, service: "auth", account: "accessToken")
        UserDefaults.standard.set(email, forKey: "currentUserEmail")
    }

    func logout() {
        KeychainHelper.shared.remove(service: "auth", account: "accessToken")
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
    }
}

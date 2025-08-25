//
//  KeychainHelper.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation
import Security


final class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}
    
    
    func set(_ data: Data, for key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    // Save or update
        func save(_ data: Data, service: String, account: String) {
            let query: [String: Any] = [
                kSecClass as String       : kSecClassGenericPassword,
                kSecAttrService as String : service,
                kSecAttrAccount as String : account,
                kSecValueData as String   : data
            ]

            // Try to add first
            let status = SecItemAdd(query as CFDictionary, nil)

            if status == errSecDuplicateItem {
                // Update existing
                let attributesToUpdate: [String: Any] = [kSecValueData as String: data]
                SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            }
        }

        // Convenience for saving Strings
        func save(_ value: String, service: String, account: String) {
            if let data = value.data(using: .utf8) {
                save(data, service: service, account: account)
            }
        }
    
    func get(_ key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
    
    
    func remove(_ key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
 

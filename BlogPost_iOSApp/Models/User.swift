//
//  User.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let username: String
    let email: String
    
    var displayName: String {
            username + " (\(email))"
        }
    
    enum CodingKeys: String, CodingKey {
            case id, username, email
        }
    
    // Custom initializer to convert Int id to String
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Convert id to String
            if let intId = try? container.decode(Int.self, forKey: .id) {
                id = String(intId)
            } else if let stringId = try? container.decode(String.self, forKey: .id) {
                id = stringId
            } else {
                throw DecodingError.dataCorruptedError(forKey: .id,
                                                       in: container,
                                                       debugDescription: "ID is not a valid Int or String")
            }
            
            username = try container.decode(String.self, forKey: .username)
            email = try container.decode(String.self, forKey: .email)
        }
    // We don’t really need password in the client app
}

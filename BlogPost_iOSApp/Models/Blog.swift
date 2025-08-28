//
//  Blog.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation

struct Blog: Codable, Identifiable, Hashable {
    let id: String
    var title: String
    var details: String
    var owners: [BlogOwner]
    var lastUpdateTime: String?

    struct BlogOwner: Codable, Identifiable, Hashable {
        var id: String
        var name: String
        var email: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case username
            case email
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Handle Int or String id
            if let intId = try? container.decode(Int.self, forKey: .id) {
                self.id = String(intId)
            } else {
                self.id = try container.decode(String.self, forKey: .id)
            }
            
            // Prefer "name", fallback to "username"
            if let name = try? container.decode(String.self, forKey: .name) {
                self.name = name
            } else {
                self.name = try container.decode(String.self, forKey: .username)
            }
            
            self.email = try container.decode(String.self, forKey: .email)
        }
        
        func encode(to encoder: Encoder) throws {
                    var container = encoder.container(keyedBy: CodingKeys.self)

                    // Try encoding id as Int if possible, else as String
                    if let intId = Int(id) {
                        try container.encode(intId, forKey: .id)
                    } else {
                        try container.encode(id, forKey: .id)
                    }

                    try container.encode(name, forKey: .name)
                    try container.encode(email, forKey: .email)
                }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, details, owners, lastUpdateTime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Handle Int or String id
        if let intId = try? container.decode(Int.self, forKey: .id) {
            self.id = String(intId)
        } else {
            self.id = try container.decode(String.self, forKey: .id)
        }
        
        self.title = try container.decode(String.self, forKey: .title)
        self.details = try container.decode(String.self, forKey: .details)
        self.owners = try container.decode([BlogOwner].self, forKey: .owners)
        self.lastUpdateTime = try? container.decode(String.self, forKey: .lastUpdateTime)
    }

    // convenience: owner emails
    var ownerEmails: [String] { owners.map { $0.email } }

    // check edit permission by email
    func canEdit(loggedInEmail: String?) -> Bool {
        guard let email = loggedInEmail else { return false }
        return owners.contains { $0.email == email }
    }
}

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

    struct BlogOwner: Codable, Hashable {
        let id: String
        let name: String
        let email: String
    }

    // convenience: owner emails
    var ownerEmails: [String] { owners.map { $0.email } }

    // check edit permission by email
    func canEdit(loggedInEmail: String?) -> Bool {
        guard let email = loggedInEmail else { return false }
        return owners.contains { $0.email == email }
    }
}

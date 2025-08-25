//
//  User.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation


struct User: Codable, Identifiable, Hashable {
let id: String // or Int; match your backend
let email: String
let firstName: String?
let lastName: String?


var displayName: String { [firstName, lastName].compactMap{$0}.joined(separator: " ").isEmpty ? email : [firstName, lastName].compactMap{$0}.joined(separator: " ") }
}

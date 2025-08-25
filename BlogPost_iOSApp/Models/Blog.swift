//
//  Blog.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation


struct Blog: Codable, Identifiable, Hashable {
let id: String // or Int
var title: String
var details: String
let ownerId: String // or Int
var coOwnerIds: [String] // or [Int]


enum CodingKeys: String, CodingKey {
case id, title, details, ownerId, coOwnerIds
}
}

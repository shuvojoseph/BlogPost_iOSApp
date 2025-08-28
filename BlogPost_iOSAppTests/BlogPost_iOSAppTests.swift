//
//  BlogPost_iOSAppTests.swift
//  BlogPost_iOSAppTests
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Testing
import Foundation
@testable import BlogPost_iOSApp

struct BlogPost_iOSAppTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test func testUserDecodingWithUsername() async throws {
        let jsonString = """
            {
                "id": 1,
                "username": "shuvo",
                "email": "shuvo@example.com"
            }
            """
        let jsonData = jsonString.data(using: String.Encoding.utf8)!
        
        let user = try JSONDecoder().decode(User.self, from: jsonData)
        #expect(user.username == "shuvo")
        #expect(user.email == "shuvo@example.com")
    }
    
    @Test func testUserDecodingWithNameInsteadOfUsername() async throws {
        let json = """
            {
                "id": "2",
                "name": "joseph",
                "email": "joseph@example.com"
            }
            """.data(using: .utf8)!
        
        let user = try JSONDecoder().decode(User.self, from: json)
        #expect(user.username == "joseph")
        #expect(user.email == "joseph@example.com")
    }
}

//
//  JWTDecoder.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation


struct JWTClaims: Codable {
    let sub: String?
    let email: String?
    let firstName: String?
    let lastName: String?
}


enum JWTDecoder {
    static func decode(_ jwt: String) -> JWTClaims? {
        let segments = jwt.split(separator: ".")
        guard segments.count >= 2 else { return nil }
        let payload = String(segments[1])
        var base64 = payload.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        let padLength = 4 - base64.count % 4
        if padLength < 4 { base64 += String(repeating: "=", count: padLength) }
        guard let data = Data(base64Encoded: base64) else { return nil }
        return try? JSONDecoder().decode(JWTClaims.self, from: data)
    }
}

//
//  AppConfig.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation

/*
enum AppConfig {
    static var baseURL: URL {
        let value = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
        guard let str = value, let url = URL(string: str) else {
            fatalError("BASE_URL missing or invalid in Info.plist")
        }
        return url
    }
}
*/

enum AppConfig {
    static var baseURLString: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "BASE_URL_SpringBoot") as? String else {
            fatalError("BASE_URL missing or invalid in Info.plist")
        }
        return value
    }
}

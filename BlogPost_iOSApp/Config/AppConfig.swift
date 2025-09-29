//
//  AppConfig.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import Foundation

enum AppConfig {
    static var baseURLString: String {
        
        guard let value = Bundle.main.object(forInfoDictionaryKey: "BASE_URL_RenderCloud") as? String else {
            fatalError("BASE_URL missing or invalid in Info.plist")
        }
        /*
        guard let value = Bundle.main.object(forInfoDictionaryKey: "BASE_URL_SpringBoot") as? String else {
            fatalError("BASE_URL missing or invalid in Info.plist")
        }
        */
        /*
        guard let value = Bundle.main.object(forInfoDictionaryKey: "BASE_URL_DotNetCore") as? String else {
            fatalError("BASE_URL missing or invalid in Info.plist")
        }
        */
        /*
        guard let value = Bundle.main.object(forInfoDictionaryKey: "BASE_URL_DotNetCore_Clean_Architecture") as? String else {
            fatalError("BASE_URL missing or invalid in Info.plist")
        }
        */
        return value
    }
}

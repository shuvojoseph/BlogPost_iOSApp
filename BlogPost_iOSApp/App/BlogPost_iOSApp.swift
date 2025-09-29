//
//  BlogPost_iOSAppApp.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI

@main
struct BlogPost_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            let apiClient = APIClient.shared
            let blogService = BlogService(apiClient: apiClient)
            let blogListVM = BlogListViewModel(blogService: blogService)
            
            BlogListView(blogService: blogService)
        }
    }
}

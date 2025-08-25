//
//  BlogDetailView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI


struct BlogDetailView: View {
    let blogId: String
    @StateObject private var viewModel = BlogDetailViewModel()
    
    
    var body: some View {
        VStack {
            if let blog = viewModel.blog {
                Text(blog.title).font(.headline)
                Text(blog.details).padding()
            } else {
                ProgressView()
            }
        }
        .onAppear { viewModel.loadBlog(id: blogId) }
    }
}

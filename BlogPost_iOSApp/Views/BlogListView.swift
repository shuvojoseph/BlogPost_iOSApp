//
//  BlogListView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI


struct BlogListView: View {
    @StateObject private var viewModel = BlogListViewModel()
    
    
    var body: some View {
        NavigationView {
            List(viewModel.blogs) { blog in
                NavigationLink(destination: BlogDetailView(blogId: blog.id)) {
                    Text(blog.title)
                }
            }
            .navigationTitle("Blogs")
            .onAppear { viewModel.loadBlogs() }
        }
    }
}

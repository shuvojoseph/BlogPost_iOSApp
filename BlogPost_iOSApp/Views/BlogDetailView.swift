//
//  BlogDetailView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI


struct BlogDetailView: View {
    //let blogId: String
    let blog: Blog?
    //@StateObject private var viewModel = BlogDetailViewModel()
    
    
    var body: some View {
        VStack {
            if let blog = blog {
                Text(blog.title).font(.headline)
                Text(blog.details).padding()
            } else {
                ProgressView()
            }
        }
        .onAppear {}
    }
}

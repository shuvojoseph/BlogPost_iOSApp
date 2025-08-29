//
//  BlogDetailView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI

struct BlogDetailView: View {
    let blog: Blog?
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.05), Color.purple.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if let blog = blog {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 12) {
                            Text(blog.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            HStack(spacing: 16) {
                                Label("Auther", systemImage: "person.circle.fill")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Content
                        Text(blog.details)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(6)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, 24)
                }
            } else {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
/*
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
*/

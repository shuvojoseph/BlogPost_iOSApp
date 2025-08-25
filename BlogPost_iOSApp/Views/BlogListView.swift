//
//  BlogListView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI

/*
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
*/

struct BlogListView: View {
    @StateObject private var viewModel = BlogListViewModel()
    @State private var showingLogin = false
    @State private var showingRegister = false
    @State private var showingAddBlog = false
    @State private var showingEditBlog: Blog?

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.blogs) { blog in
                    NavigationLink(destination: BlogDetailView(blog: blog)) {
                        BlogDetailView(blog: blog)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteBlog(blog)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }

                        Button {
                            showingEditBlog = blog
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Button("Login") { showingLogin = true }
                        Button("Register") { showingRegister = true }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddBlog = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingLogin) {
                LoginView()
            }
            .sheet(isPresented: $showingRegister) {
                RegisterView()
            }
            .sheet(isPresented: $showingAddBlog) {
                //BlogFormView(viewModel: BlogFormViewModel())
            }
            .sheet(item: $showingEditBlog) { blog in
                //BlogFormView(viewModel: BlogFormViewModel(blog: blog))
            }
            .onAppear {
                viewModel.loadBlogs()
            }
        }
    }
}


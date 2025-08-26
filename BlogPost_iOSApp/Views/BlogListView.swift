import SwiftUI

struct BlogListView: View {
    @StateObject private var viewModel = BlogListViewModel()
    @State private var showingLogin = false
    @State private var showingRegister = false
    @State private var showingAddBlog = false
    @State private var showingEditBlog: Blog?

    var body: some View {
        NavigationStack {
            blogList
                .navigationTitle("Dashboard")
                .toolbar { toolbarContent }
                .sheet(isPresented: $showingLogin) { LoginView() }
                .sheet(isPresented: $showingRegister) { RegisterView() }
                .sheet(isPresented: $showingAddBlog) {
                    // BlogFormView(viewModel: BlogFormViewModel())
                }
                .sheet(item: $showingEditBlog) { blog in
                    // BlogFormView(viewModel: BlogFormViewModel(blog: blog))
                }
                .onAppear {
                    viewModel.loadBlogs()
                    viewModel.loadCurrentUser()
                }
        }
    }

    // MARK: - Subviews

    private var blogList: some View {
        List {
            ForEach(viewModel.blogs) { blog in
                blogRow(blog)
            }
        }
    }

    private func blogRow(_ blog: Blog) -> some View {
        NavigationLink(destination: BlogDetailView(blog: blog)) {
            VStack(alignment: .leading, spacing: 4) {
                Text(blog.title).font(.headline)
                Text(blog.details)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .swipeActions {
            if viewModel.isOwnedOrCoOwned(blog: blog) {
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

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if viewModel.isLoggedIn {
                Button("Logout") {
                    viewModel.logout()
                }
            } else {
                HStack {
                    Button("Login") { showingLogin = true }
                    Button("Register") { showingRegister = true }
                }
            }
        }

        ToolbarItem(placement: .navigationBarTrailing) {
            if viewModel.isLoggedIn {
                Button {
                    showingAddBlog = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

import SwiftUI

struct BlogListView: View {
    let blogService: BlogServiceProtocol
    @StateObject private var viewModel: BlogListViewModel

    init(blogService: BlogServiceProtocol) {
        self.blogService = blogService
        _viewModel = StateObject(wrappedValue: BlogListViewModel(blogService: blogService))
    }
    @State private var showingLogin = false
    @State private var showingRegister = false
    @State private var showingAddBlog = false
    @State private var showingEditBlog: Blog?
    @State private var searchText = ""
    
    var filteredBlogs: [Blog] {
        if searchText.isEmpty {
            return viewModel.blogs
        } else {
            return viewModel.blogs.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.details.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.indigo.opacity(0.05), Color.purple.opacity(0.05)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if viewModel.blogs.isEmpty {
                    emptyStateView
                } else {
                    blogList
                }
            }
            .navigationTitle("Dashboard")
            .toolbar { toolbarContent }
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search blogs...")
            .sheet(isPresented: $showingLogin) { LoginView() }
            .sheet(isPresented: $showingRegister) { RegisterView() }
            .sheet(isPresented: $showingAddBlog) {
                AddEditBlogView(viewModel: viewModel, blogService: blogService)
            }
            .sheet(item: $showingEditBlog) { blog in
                AddEditBlogView(viewModel: viewModel, blogToEdit: blog, blogService: blogService)
            }
            .refreshable {
                viewModel.loadBlogs()
            }
            .onAppear {
                print("BlogListView onAppear")
                viewModel.loadBlogs()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.richtext.fill")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
                .opacity(0.5)
            
            Text("No Blogs Yet")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            
            Text(viewModel.isLoggedIn ?
                 "Tap the + button to create your first blog!" :
                 "Sign in to start writing your story")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if !viewModel.isLoggedIn {
                Button("Sign In") {
                    showingLogin = true
                }
                .buttonStyle(BeautifulButtonStyle(backgroundColor: .blue))
                .padding(.top, 10)
            }
        }
    }
    
    private var blogList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredBlogs) { blog in
                    blogCard(blog)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
    
    private func blogCard(_ blog: Blog) -> some View {
        NavigationLink(destination: BlogDetailView(blog: blog)) {
            VStack(alignment: .leading, spacing: 12) {
                // Header with title and menu
                HStack {
                    Text(blog.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    if viewModel.isOwnedOrCoOwned(blog: blog) {
                        Menu {
                            Button {
                                showingEditBlog = blog
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            
                            Button(role: .destructive) {
                                viewModel.deleteBlog(blog)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle.fill")
                                .foregroundColor(.secondary)
                                .padding(4)
                        }
                    }
                }
                
                // Blog content preview
                Text(blog.details)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                // Footer with metadata
                HStack {
                    Text("Auther")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    /*
                     if let date = blog.createdAt {
                     Text(date, style: .relative)
                     .font(.caption)
                     .foregroundColor(.secondary)
                     }
                     */
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if viewModel.isLoggedIn {
                Button("Logout") {
                    viewModel.logout()
                }
                .foregroundColor(.red)
            } else {
                HStack(spacing: 16) {
                    Button("Login") { showingLogin = true }
                        .buttonStyle(BeautifulOutlineButtonStyle())
                    
                    Button("Register") { showingRegister = true }
                        .buttonStyle(BeautifulOutlineButtonStyle())
                }
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            if viewModel.isLoggedIn {
                Button {
                    showingAddBlog = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

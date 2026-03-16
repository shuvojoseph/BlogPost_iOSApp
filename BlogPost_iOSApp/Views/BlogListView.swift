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
                    BlogEmptyStateView(isLoggedIn: viewModel.isLoggedIn) {
                        showingLogin = true
                    }
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
    
    private var blogList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredBlogs) { blog in
                    BlogCardView(
                        blog: blog,
                        isOwnedOrCoOwned: viewModel.isOwnedOrCoOwned(blog:),
                        onEdit: { showingEditBlog = $0 },
                        onDelete: { viewModel.deleteBlog($0) }
                    )
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        BlogListToolbar(
            isLoggedIn: viewModel.isLoggedIn,
            onLogout: { viewModel.logout() },
            onLogin: { showingLogin = true },
            onRegister: { showingRegister = true },
            onAdd: { showingAddBlog = true }
        )
    }
}

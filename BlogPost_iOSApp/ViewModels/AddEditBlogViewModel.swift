//
//  AddEditBlogViewModel.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 26/8/25.
//

import Foundation

final class AddEditBlogViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var details: String = ""
    @Published var selectedCoOwnerIds: Set<String> = []
    @Published var isSaving: Bool = false
    @Published var errorMessage: String?

    private(set) var editingId: String?

    init(blog: Blog? = nil) {
        if let blog = blog {
            editingId = blog.id
            title = blog.title
            details = blog.details
            // initialize selected co-owner ids from owners (exclude the implicit owner if needed)
            selectedCoOwnerIds = Set(blog.owners.map { $0.id })
        }
    }

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !details.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    /// Save (create or update) — calls completion on main thread
    func save(completion: @escaping (Result<Blog, Error>) -> Void) {
        guard isValid else {
            DispatchQueue.main.async {
                self.errorMessage = "Title and Details are required"
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid input"])))
            }
            return
        }

        isSaving = true
        errorMessage = nil
        let coOwnerIdsArray = Array(selectedCoOwnerIds)

        if let id = editingId {
            // Update
            BlogService.shared.updateBlog(id: id, title: title, details: details, coOwnerIds: coOwnerIdsArray) { result in
                DispatchQueue.main.async {
                    self.isSaving = false
                    switch result {
                    case .success(let blog):
                        completion(.success(blog))
                    case .failure(let err):
                        self.errorMessage = err.localizedDescription
                        completion(.failure(err))
                    }
                }
            }
        } else {
            // Create
            BlogService.shared.createBlog(title: title, details: details, coOwnerIds: coOwnerIdsArray) { result in
                DispatchQueue.main.async {
                    self.isSaving = false
                    switch result {
                    case .success(let blog):
                        completion(.success(blog))
                    case .failure(let err):
                        self.errorMessage = err.localizedDescription
                        completion(.failure(err))
                    }
                }
            }
        }
    }
}

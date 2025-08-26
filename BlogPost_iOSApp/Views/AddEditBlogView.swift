//
//  AddEditBlogView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 26/8/25.
//

import SwiftUICore
import SwiftUI
/*
struct AddEditBlogView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String
    @State private var content: String
    
    var blog: Blog?
    var onSave: (Blog) -> Void
    
    init(blog: Blog? = nil, onSave: @escaping (Blog) -> Void) {
        self.blog = blog
        _title = State(initialValue: blog?.title ?? "")
        _content = State(initialValue: blog?.details ?? "")
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle(blog == nil ? "Add Blog" : "Edit Blog")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newBlog = Blog(
                            id: blog?.id ?? String(Int.random(in: 1000...9999)),
                            title: title,
                            details: content,
                            ownerId: AuthManager.shared.currentUserId ?? String(-1)
                        )
                        onSave(newBlog)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
*/

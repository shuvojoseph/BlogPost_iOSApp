// Create a new SwiftUI view component for rendering a single blog card.
// This file must be self-contained and compile independently when used by BlogListView.

import SwiftUI

struct BlogCardView: View {
    let blog: Blog
    let isOwnedOrCoOwned: (Blog) -> Bool
    var onEdit: (Blog) -> Void
    var onDelete: (Blog) -> Void

    var body: some View {
        NavigationLink(destination: BlogDetailView(blog: blog)) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(blog.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    Spacer()

                    if isOwnedOrCoOwned(blog) {
                        Menu {
                            Button {
                                onEdit(blog)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }

                            Button(role: .destructive) {
                                onDelete(blog)
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

                Text(blog.details)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)

                HStack {
                    Text("Author")
                        .font(.caption)
                        .foregroundColor(.blue)

                    Spacer()
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
}

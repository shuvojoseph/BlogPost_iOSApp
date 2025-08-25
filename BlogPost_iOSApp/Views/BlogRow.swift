//
//  BlogRow.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI

struct BlogRow: View {
    let blog: Blog
    let canEdit: Bool
    let onEdit: () -> Void

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(blog.title)
                    .font(.headline)
                Text(blog.details)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer()
            if canEdit {
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                }
                .buttonStyle(.borderless) // avoids triggering row navigation
                .accessibilityLabel("Edit")
            }
        }
        .contentShape(Rectangle())
    }
}

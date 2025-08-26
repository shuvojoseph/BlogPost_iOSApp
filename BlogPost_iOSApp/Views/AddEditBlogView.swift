//
//  AddEditBlogView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 26/8/25.
//

import SwiftUICore
import SwiftUI

struct AddEditBlogView: View {
    @Environment(\.dismiss) private var dismiss

    // Parent list VM (so we can refresh the list after save)
    @ObservedObject private var parentViewModel: BlogListViewModel

    // Local form vm
    @StateObject private var vm: AddEditBlogViewModel

    // UI
    @State private var showingUsersPicker = false

    init(viewModel parent: BlogListViewModel, blogToEdit: Blog? = nil) {
        self.parentViewModel = parent
        _vm = StateObject(wrappedValue: AddEditBlogViewModel(blog: blogToEdit))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Blog") {
                    TextField("Title", text: $vm.title)
                    TextEditor(text: $vm.details)
                        .frame(minHeight: 140, maxHeight: 300)
                }

                Section("Co-owners") {
                    Button("Select co-owners (\(vm.selectedCoOwnerIds.count))") {
                        showingUsersPicker = true
                    }
                    if !vm.selectedCoOwnerIds.isEmpty {
                        // Show names/ids briefly (you can map to user names if you store them)
                        Text(vm.selectedCoOwnerIds.joined(separator: ", "))
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }

                if let err = vm.errorMessage {
                    Section { Text(err).foregroundColor(.red) }
                }
            }
            .navigationTitle(vm.editingId == nil ? "Add Blog" : "Edit Blog")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: saveTapped) {
                        if vm.isSaving {
                            ProgressView().scaleEffect(0.75)
                        } else {
                            Text("Save")
                        }
                    }
                    .disabled(!vm.isValid || vm.isSaving)
                }
            }
            .sheet(isPresented: $showingUsersPicker) {
                UsersSelectionView(selected: $vm.selectedCoOwnerIds)
            }
        }
    }

    private func saveTapped() {
        vm.save { result in
            switch result {
            case .success(let blog):
                DispatchQueue.main.async {
                    // update parent list and dismiss
                    parentViewModel.refreshBlogs(with: blog)
                    dismiss()
                }
            case .failure:
                // errorMessage on vm already set; keep the sheet open
                break
            }
        }
    }
}


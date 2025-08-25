//
//  BlogFormView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI
/*
struct BlogFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = BlogFormViewModel()   // assuming you already have this VM
    let existing: Blog?                                  // pass a Blog to edit; nil to add

    @State private var showingUsers = false

    init(existing: Blog? = nil) {
        self.existing = existing
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Blog") {
                    TextField("Title", text: $vm.title)
                    TextField("Description", text: $vm.details, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }

                Section("Co-owners") {
                    Button("Select Users (\(vm.selectedCoOwnerIds.count))") {
                        showingUsers = true
                    }
                    if !vm.selectedCoOwnerIds.isEmpty {
                        Text(Array(vm.selectedCoOwnerIds).joined(separator: ", "))
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                if let err = vm.errorMessage {
                    Section { Text(err).foregroundColor(.red) }
                }
            }
            .navigationTitle(existing == nil ? "Add Blog" : "Edit Blog")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(vm.isSaving ? "Saving..." : "Save") {
                        vm.save { ok in if ok { dismiss() } }
                    }
                    .disabled(!vm.isValid || vm.isSaving)
                }
            }
            .onAppear {
                if let blog = existing {
                    vm.configureForEdit(blog)
                }
            }
            .sheet(isPresented: $showingUsers) {
                UsersSelectionView(selected: $vm.selectedCoOwnerIds)
            }
        }
    }
}
*/

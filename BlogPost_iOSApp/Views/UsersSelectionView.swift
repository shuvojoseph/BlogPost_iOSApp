//
//  UsersSelectionView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 26/8/25.
//

import SwiftUI

struct UsersSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selected: Set<String>
    @StateObject private var vm = UsersSelectionViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(vm.users) { user in
                        Button {
                            if selected.contains(user.id) {
                                selected.remove(user.id)
                            } else {
                                selected.insert(String(user.id))
                            }
                        } label: {
                            HStack {
                                Text(user.displayName)
                                Spacer()
                                if selected.contains(user.id) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle("Select Co-owners")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .onAppear { vm.loadUsers() }
    }
}

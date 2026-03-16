// Toolbar content builder extracted from BlogListView.

import SwiftUI

struct BlogListToolbar: ToolbarContent {
    let isLoggedIn: Bool
    var onLogout: () -> Void
    var onLogin: () -> Void
    var onRegister: () -> Void
    var onAdd: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if isLoggedIn {
                Button("Logout") { onLogout() }
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .medium))
            } else {
                Button(action: onLogin) {
                    Text("Login")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 1.5)
                        )
                }
            }
        }

        ToolbarItem(placement: .navigationBarTrailing) {
            if isLoggedIn {
                Button(action: onAdd) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            } else {
                Button(action: onRegister) {
                    Text("Register")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue)
                        )
                }
            }
        }
    }
}

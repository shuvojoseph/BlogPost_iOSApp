// Self-contained empty state view used by BlogListView.

import SwiftUI

struct BlogEmptyStateView: View {
    let isLoggedIn: Bool
    var onSignIn: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.richtext.fill")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
                .opacity(0.5)

            Text("No Blogs Yet")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)

            Text(isLoggedIn ?
                 "Tap the + button to create your first blog!" :
                 "Sign in to start writing your story")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            if !isLoggedIn {
                Button("Sign In") {
                    onSignIn()
                }
                .buttonStyle(BeautifulButtonStyle(backgroundColor: .blue))
                .padding(.top, 10)
            }
        }
    }
}

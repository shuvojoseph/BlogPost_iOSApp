//
//  LoginView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityIdentifier("emailField")
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityIdentifier("passwordField")
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            
            
            Button("Login") {
                viewModel.login { success in
                    if success {
                        presentationMode.wrappedValue.dismiss() // ✅ back to BlogListView
                    }
                }
            }.accessibilityIdentifier("loginButton")
        }
        .padding()
    }
}

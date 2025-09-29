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
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                        
                        Text("Welcome Back")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Sign in to continue your journey")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // Form
                    VStack(spacing: 20) {
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                            
                            TextField("Enter your email", text: $viewModel.email)
                                .textFieldStyle(BeautifulTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .focused($focusedField, equals: .email)
                                .submitLabel(.next)
                                .accessibilityIdentifier("emailField")
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                            
                            SecureField("Enter your password", text: $viewModel.password)
                                .textFieldStyle(BeautifulTextFieldStyle())
                                .focused($focusedField, equals: .password)
                                .submitLabel(.go)
                                .accessibilityIdentifier("passwordField")
                        }
                    }
                    .padding(.horizontal)
                    
                    // Error Message
                    if let error = viewModel.errorMessage {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text(error)
                        }
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    // Login Button
                    Button(action: handleLogin) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Sign In")
                                .fontWeight(.semibold)
                        }
                    }
                    .buttonStyle(BeautifulButtonStyle())
                    .disabled(viewModel.isLoading)
                    .accessibilityIdentifier("loginButton")
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
            }
            .onSubmit {
                switch focusedField {
                case .email:
                    focusedField = .password
                case .password:
                    handleLogin()
                case .none:
                    break
                }
            }
        }
    }
    
    private func handleLogin() {
        viewModel.login { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

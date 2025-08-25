//
//  LoginView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI


import SwiftUI


struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            
            Button("Login") {
                viewModel.login { success in }
            }
        }
        .padding()
    }
}

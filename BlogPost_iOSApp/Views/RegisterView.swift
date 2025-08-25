//
//  RegisterView.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//

import SwiftUI


struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            
            Button("Register") {
                viewModel.register { success in }
            }
        }
        .padding()
    }
}

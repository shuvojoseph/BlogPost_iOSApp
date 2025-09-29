//
//  README.md
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 29/9/25.
//
BlogPost iOS App

An iOS application that allows users to register, log in, and manage blogs with co-owner functionality. Built with SwiftUI using MVVM architecture, this app demonstrates clean architecture, API integration, secure authentication, and automated testing.

🚀 Features

Dashboard

Displays all blogs with Login and Register buttons.

Authentication

Any user can register and log in (no verification flow).

JWT authentication for all secured endpoints.

Blog Management

Add, edit, and delete blogs after login.

Add a co-owner from the user list.

Any co-owner can also edit or delete the blog.

Architecture

Built using MVVM for separation of concerns.

Networking

Alamofire for API calls.

Codable for parsing API responses.

APIClient as the common gateway for all API requests.

BlogService and UserService for domain-specific API logic.

Authentication

Login state handled with AuthManager.

Secure token storage with KeychainHelper.

Testing

Unit Tests for models and API response decoding.

UI Tests for login/logout flow and navigation.

🛠️ Tech Stack

SwiftUI for UI

MVVM architecture

Alamofire for networking

Codable for JSON parsing

Keychain for secure token storage

XCTest for Unit & UI testing

📂 Project Structure
BlogPost_iOSApp/
│── App/            # BlogPost_iOSApp
│── Models/         # Blog, User, API response models
│── Services/       # BlogService, UserService, APIClient
│── Networking/     # APIClient, Endpoint, APIError
│── ViewModels/     # MVVM layer managing state & logic
│── Views/          # SwiftUI Views (Dashboard, Login, Register, BlogForm)
│── Managers/       # AuthManager, KeychainHelper
│── Tests/          # Unit tests
│── UITests/        # UI tests
│── README.md       # Project documentation

🔑 Authentication

JWT tokens are stored securely in Keychain.

All API calls requiring authentication attach the token automatically.

🧪 Testing

Unit Tests: Verify model decoding and authentication logic.

UI Tests: Validate login/logout flow, navigation to Dashboard, and button accessibility identifiers.

📦 API

Backend APIs are hosted on Render Cloud:

Blog CRUD endpoints

User authentication & registration

Co-owner management

▶️ Getting Started

Clone the repository

git clone https://github.com/yourusername/BlogPost_iOSApp.git

Install dependencies (CocoaPods).
pod install
                        
Open in Xcode

open BlogPost_iOSApp.xcodeproj

Run on iOS Simulator or a real device.

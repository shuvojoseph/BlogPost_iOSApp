//
//  Endpoint.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 25/8/25.
//
import Foundation


enum Endpoint {
    case login
    case register
    case blogs
    case blog(id: String)
    case createBlog
    case updateBlog(id: String)
    case deleteBlog(id: String)
    
    
    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .register: return "/auth/register"
        case .blogs: return "/blogs"
        case .blog(let id): return "/blogs/\(id)"
        case .createBlog: return "/blogs"
        case .updateBlog(let id): return "/blogs/\(id)"
        case .deleteBlog(let id): return "/blogs/\(id)"
        }
    }
    
    
    var method: String {
        switch self {
        case .login, .register, .createBlog: return "POST"
        case .updateBlog: return "PUT"
        case .deleteBlog: return "DELETE"
        case .blogs, .blog: return "GET"
        }
    }
}

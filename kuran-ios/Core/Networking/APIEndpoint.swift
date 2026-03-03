//
//  APIEndpoint.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//

import Foundation


struct APIEndpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Encodable?
    
    init(
        path: String,
        method: HTTPMethod,
        headers: [String: String]? = ["Content-Type": "application/json"],
        body: Encodable? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
    }
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}


extension APIEndpoint {
    static func login(email: String, password: String) -> APIEndpoint {
        struct LoginRequest: Encodable {
            let email: String
            let password: String
        }
        
        return APIEndpoint(
            path: "/auth/login",
            method: .post,
            body: LoginRequest(email: email, password: password)
        )
    }
    
    static func register(email: String, username: String, password: String) -> APIEndpoint {
        struct RegisterRequest: Encodable {
            let email: String
            let username: String
            let password: String
        }
        
        return APIEndpoint(
            path: "/auth/register",
            method: .post,
            body: RegisterRequest(email: email, username: username, password: password)
        )
    }
    
    static func logout(token: String) -> APIEndpoint {
        return APIEndpoint(
            path: "/auth/logout",
            method: .post,
            headers: ["Authorization": "Bearer \(token)"]
        )
    }
    
    static func deleteProfile(token: String) -> APIEndpoint {
        return APIEndpoint(
            path: "/auth/me",
            method: .delete,
            headers: ["Authorization": "Bearer \(token)"]
        )
    }
}

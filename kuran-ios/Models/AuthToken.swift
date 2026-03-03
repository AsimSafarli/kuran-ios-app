//
//  AuthToken.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//




import Foundation


struct AuthToken: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: Date
    
    init(
        accessToken: String,
        refreshToken: String,
        expiresAt: Date
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresAt = expiresAt
    }
    
    var isExpired: Bool {
        return Date() > expiresAt
    }
}

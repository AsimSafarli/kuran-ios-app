//
//  User.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//




import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: String
    let email: String
    let name: String
//    let profileImageURL: String?
//    let createdAt: Date
    
    init(
        id: String,
        email: String,
        name: String
//        profileImageURL: String? = nil,
//        createdAt: Date = Date()
    ) {
        self.id = id
        self.email = email
        self.name=name
//        self.username = username
//        self.profileImageURL = profileImageURL
//        self.createdAt = createdAt
    }
}

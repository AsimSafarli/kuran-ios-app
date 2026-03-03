//
//  AuthResponseDTO.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//



import Foundation


struct AuthResponseDTO: Decodable {
    let user: UserDTO
    let token: AuthTokenDTO
}


struct UserDTO: Decodable {
    let id: String
    let email: String
    let name: String
//    let profileImageURL: String?
//    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
//        case profileImageURL = "profile_image_url"
//        case createdAt = "created_at"
    }
    
    func toDomain() -> User {
//        let dateFormatter = ISO8601DateFormatter()
//        let date = dateFormatter.date(from: createdAt) ?? Date()
        
        return User(
            id: id,
            email: email,
            name: name
//            profileImageURL: profileImageURL,
//            createdAt: date
        )
    }
}


struct AuthTokenDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
    
    func toDomain() -> AuthToken {
        let expiresAt = Date().addingTimeInterval(TimeInterval(expiresIn))
        
        return AuthToken(
            accessToken: accessToken,
            refreshToken: refreshToken,
            expiresAt: expiresAt
        )
    }
}

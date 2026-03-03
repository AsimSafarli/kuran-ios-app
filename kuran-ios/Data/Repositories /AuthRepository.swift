//
//  AuthRepository.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//

import Foundation


final class AuthRepository: AuthRepositoryProtocol {
    private let apiClient: APIClientProtocol
    private let tokenStorage: TokenStorageProtocol
    
    init(
        apiClient: APIClientProtocol,
        tokenStorage: TokenStorageProtocol
    ) {
        self.apiClient = apiClient
        self.tokenStorage = tokenStorage
    }
    
    func login(email: String, password: String) async throws -> (User, AuthToken) {
        let response: AuthResponseDTO = try await apiClient.request(
            .login(email: email, password: password)
        )
        
        let user = response.user.toDomain()
        let token = response.token.toDomain()
        
        return (user, token)
    }
    
    func register(email: String, username: String, password: String) async throws -> (User, AuthToken) {
        let response: AuthResponseDTO = try await apiClient.request(
            .register(email: email, username: username, password: password)
        )
        
        let user = response.user.toDomain()
        let token = response.token.toDomain()
        
        return (user, token)
    }
    
    func logout() async throws {
        guard let token = tokenStorage.getToken() else {
            throw AuthError.unauthorized
        }
        
        let _: EmptyResponse = try await apiClient.request(
            .logout(token: token)
        )
    }
    
    func deleteProfile() async throws {
        guard let token = tokenStorage.getToken() else {
            throw AuthError.unauthorized
        }
        
        let _: EmptyResponse = try await apiClient.request(
            .deleteProfile(token: token)
        )
    }
    
    func getCurrentUser() async throws -> User? {
        return tokenStorage.getCurrentUser()
    }
    
    func refreshToken() async throws -> AuthToken {
        throw AuthError.unknown
    }
}


struct EmptyResponse: Decodable {}

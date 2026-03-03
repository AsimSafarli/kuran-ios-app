//
//  TokenStorageProtocol.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//


import Foundation


protocol TokenStorageProtocol {
    func saveToken(_ token: AuthToken, rememberMe: Bool)
    func saveUser(_ user: User)
    func getToken() -> String?
    func getCurrentUser() -> User?
    func clearToken()
    func isRememberMeEnabled() -> Bool
}


final class TokenStorage: TokenStorageProtocol {
    private let userDefaults = UserDefaults.standard
    private let keychainService: KeychainServiceProtocol
    
    private enum Keys {
        static let token = "auth_token"
        static let refreshToken = "refresh_token"
        static let user = "current_user"
        static let rememberMe = "remember_me"
        static let expiration = "token_expiration"
    }
    
    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }
    
    func saveToken(_ token: AuthToken, rememberMe: Bool) {
        keychainService.save(token.accessToken, forKey: Keys.token)
        keychainService.save(token.refreshToken, forKey: Keys.refreshToken)
        
        userDefaults.set(rememberMe, forKey: Keys.rememberMe)
        
        if rememberMe {
            let expirationDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())!
            userDefaults.set(expirationDate, forKey: Keys.expiration)
        } else {
            userDefaults.removeObject(forKey: Keys.expiration)
        }
    }
    
    func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: Keys.user)
        }
    }
    
    func getToken() -> String? {
        if let expirationDate = userDefaults.object(forKey: Keys.expiration) as? Date {
            if Date() > expirationDate {
                clearToken()
                return nil
            }
        }
        
        return keychainService.get(forKey: Keys.token)
    }
    
    func getCurrentUser() -> User? {
        guard let data = userDefaults.data(forKey: Keys.user),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil
        }
        return user
    }
    
    func clearToken() {
        keychainService.delete(forKey: Keys.token)
        keychainService.delete(forKey: Keys.refreshToken)
        userDefaults.removeObject(forKey: Keys.user)
        userDefaults.removeObject(forKey: Keys.rememberMe)
        userDefaults.removeObject(forKey: Keys.expiration)
    }
    
    func isRememberMeEnabled() -> Bool {
        return userDefaults.bool(forKey: Keys.rememberMe)
    }
}

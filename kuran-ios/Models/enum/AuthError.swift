//
//  AuthError.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//



import Foundation

enum AuthError: Error, LocalizedError {
    case emptyEmail
    case emptyPassword
    case emptyUsername
    case invalidEmail
    case weakPassword
    case invalidCredentials
    case userExists
    case networkError
    case serverError
    case unauthorized
    case tokenExpired
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Email boş ola bilməz"
        case .emptyPassword:
            return "Şifrə boş ola bilməz"
        case .emptyUsername:
            return "İstifadəçi adı boş ola bilməz"
        case .invalidEmail:
            return "Email düzgün deyil"
        case .weakPassword:
            return "Şifrə ən azı 6 simvol olmalıdır"
        case .invalidCredentials:
            return "Email və ya şifrə yanlışdır"
        case .userExists:
            return "Bu email artıq mövcuddur"
        case .networkError:
            return "İnternet bağlantısı yoxdur"
        case .serverError:
            return "Server xətası baş verdi"
        case .unauthorized:
            return "İcazə verilmədi"
        case .tokenExpired:
            return "Sessiyanız bitib, yenidən daxil olun"
        case .unknown:
            return "Naməlum xəta baş verdi"
        }
    }
}

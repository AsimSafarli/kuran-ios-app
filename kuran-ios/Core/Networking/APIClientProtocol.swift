//
//  APIClientProtocol.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//

import Foundation


protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}

final class APIClient: APIClientProtocol {
    private let baseURL: String
    private let session: URLSession
    
    init(
        baseURL: String = "API",
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        guard let url = URL(string: baseURL + endpoint.path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }
            
        case 401:
            throw APIError.unauthorized
            
        case 400...499:
            throw APIError.clientError(httpResponse.statusCode)
            
        case 500...599:
            throw APIError.serverError(httpResponse.statusCode)
            
        default:
            throw APIError.unknownError
        }
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case unauthorized
    case clientError(Int)
    case serverError(Int)
    case decodingError(Error)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL düzgün deyil"
        case .invalidResponse:
            return "Cavab düzgün deyil"
        case .unauthorized:
            return "İcazə verilmədi"
        case .clientError(let code):
            return "Client xətası: \(code)"
        case .serverError(let code):
            return "Server xətası: \(code)"
        case .decodingError:
            return "Data oxuma xətası"
        case .unknownError:
            return "Naməlum xəta"
        }
    }
}

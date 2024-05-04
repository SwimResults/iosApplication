//
//  ApiActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation
struct ApiActions {
    
    var url: String = ""
    
    func get<T:Codable>(path: String) async throws -> T {
        guard let url = URL(string: url + path) else { throw ServiceError.invalidURL }
        
        print("GET: " + url.absoluteString)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode < 300 else {
            throw ServiceError.invalidResponseCode
        }
        
        do {
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ServiceError.invalidJSON
        }
    }
}

enum ServiceError: Error {
    case invalidURL
    case invalidResponseCode
    case invalidJSON
}

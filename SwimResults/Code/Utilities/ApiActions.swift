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
            
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate]

            decoder.dateDecodingStrategy = .custom({ decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                if let date = formatter.date(from: dateString) {
                    return date
                }
                
                print("Cannot decode date string \(dateString)")
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            })
            
            return try decoder.decode(T.self, from: data)
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            throw ServiceError.invalidJSON
        }
    }
}

enum ServiceError: Error {
    case invalidURL
    case invalidResponseCode
    case invalidJSON
}

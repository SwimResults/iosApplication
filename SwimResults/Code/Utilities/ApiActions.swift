//
//  ApiActions.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import Foundation

struct ApiActions {
    
    var url: String = ""
    
    var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return encoder
    }()
    
    var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let time3Formatter = DateFormatter()
        time3Formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let time2Formatter = DateFormatter()
        time2Formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        
        let time1Formatter = DateFormatter()
        time1Formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            var dateStr = try container.decode(String.self)
            
            // possible date strings: "2016-05-01",  "2016-07-04T17:37:21.119229Z", "2018-05-20T15:00:00Z"
            
            let len = dateStr.count
            var date: Date? = nil
            
            dateStr = dateStr.replacingOccurrences(of: "0000-", with: "0001-")
            
            if len == 24 {
                date = time3Formatter.date(from: dateStr)
            } else if len == 23 {
                date = time2Formatter.date(from: dateStr)
            } else if len == 22 {
                date = time1Formatter.date(from: dateStr)
            } else {
                date = dateFormatter.date(from: dateStr)
            }
            
            
            
            guard let date_ = date else {
                print("Cannot decode date (new strat) string \(dateStr)")
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
            }
            print("DATE DECODER \(dateStr) to \(date_)")
            return date_
        })
        return decoder
    }()

    
    func get<T:Codable>(path: String) async throws -> T {
        guard let url = URL(string: url + path) else { throw ServiceError.invalidURL }
        
        print("GET: " + url.absoluteString)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode < 300 else {
            throw ServiceError.invalidResponseCode
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            throw ServiceError.invalidJSON
        }
    }
    
    func post<T:Codable, U:Codable>(path: String, params:[String:Any], data: U) async throws -> T {
        guard let url = URL(string: url + path) else { throw ServiceError.invalidURL }
        
        print("POST: " + url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = try encoder.encode(data)
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode < 300 else {
            throw ServiceError.invalidResponseCode
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            throw ServiceError.invalidJSON
        }
    }
    
//    func getPostString(params:[String:Any]) -> String
//    {
//        var data = [String]()
//        for(key, value) in params
//        {
//            data.append(key + "=\(value)")
//        }
//        return data.map { String($0) }.joined(separator: "&")
//    }
//
//    func callPost(url:URL, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
//    {
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        //let postString = self.getPostString(params: params)
//        //request.httpBody = postString.data(using: .utf8)
//
//        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if(error != nil)
//            {
//                result.message = "Fail Error not null : \(error.debugDescription)"
//            }
//            else
//            {
//                result.message = "Success"
//                result.data = data
//            }
//
//            finish(result)
//        }
//        task.resume()
//    }
//    
//    func finishPost (message:String, data:Data?) -> Void
//    {
//        do
//        {
//            if let jsonData = data
//            {
//                let parsedData = try decoder<>.decode(from: jsonData)
//                print(parsedData)
//            }
//        }
//        catch
//        {
//            print("Parse Error: \(error)")
//        }
//    }
}

enum ServiceError: Error {
    case invalidURL
    case invalidResponseCode
    case invalidJSON
}

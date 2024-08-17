//
//  APIClient.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

enum APIError: Error {
    case invalidRequest
    case invalidResponse
    case timeout
    case requestFailed(statusCode: Int)
    case decodeFailed
}

protocol APIClientProtocol {
    func performRequest<T: Decodable>(endpoint: Endpoint, decoder: JSONDecoder) async throws -> T
}

final class APIClient: NSObject, APIClientProtocol {
    
    func performRequest<T: Decodable>(endpoint: Endpoint, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
//#if DEBUG
//        if let mockfile = endpoint.mockFile, let path = Bundle.main.path(forResource: mockfile, ofType: "json") {
//            let url = URL(fileURLWithPath: path)
//            let data = try Data(contentsOf: url)
//            do {
//                let decodedData = try decoder.decode(T.self, from: data)
//                return decodedData
//            } catch {
//                print(String(describing: error))
//                throw error
//            }
//        }
//#endif
        
        guard let urlRequest = try? endpoint.asRequest() else {
            throw APIError.invalidRequest
        }
        
        do {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 10
            configuration.timeoutIntervalForResource = 10
            configuration.requestCachePolicy = .useProtocolCachePolicy
            configuration.urlCache = nil
            
            let (data, response) = try await URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
                .data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.requestFailed(statusCode: httpResponse.statusCode)
            }
            
            let decodedData = try decoder.decode(T.self, from: data)
            
            return decodedData
        } catch {
            if (error as NSError).code == NSURLErrorTimedOut {
                throw APIError.timeout
            }
            print(String(describing: error))
            throw error
        }
    }
}

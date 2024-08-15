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
#if DEBUG
        if let mockfile = endpoint.mockFile, let path = Bundle.main.path(forResource: mockfile, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try Data(contentsOf: url, options: .uncached)
            let decodedData = try decoder.decode(T.self, from: data)
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            
            print("\(mockfile): \(data.prettyPrintedJSONString ?? "")")
            
            return decodedData
        }
#endif
        
        guard let urlRequest = try? endpoint.asRequest() else {
            throw APIError.invalidRequest
        }
        
        do {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 10
            configuration.timeoutIntervalForResource = 10
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            configuration.urlCache = nil
            
            let (data, response) = try await URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
                .data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.requestFailed(statusCode: httpResponse.statusCode)
            }
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            
            print("\(response.url?.absoluteString ?? ""): \(data.prettyPrintedJSONString ?? "")")
            
            return decodedData
        } catch {
            if (error as NSError).code == NSURLErrorTimedOut {
                throw APIError.timeout
            }
            throw error
        }
    }
}

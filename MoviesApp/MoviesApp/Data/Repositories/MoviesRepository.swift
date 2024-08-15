//
//  MoviesRepository.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

struct MoviesRepository: MoviesRepositoryProtocol {
    private var apiClient: APIClientProtocol = APIClient()
    
    func getPopularMovies(language: String, page: String) async throws -> MoviesResponse {
        let model: MoviesResponse = try await apiClient.performRequest(
            endpoint: MoviesEndpoint.getPopular(language: language, page: page),
            decoder: JSONDecoder()
        )
        return model
    }

    func getTopRatedMovies(language: String, page: String) async throws -> MoviesResponse {
        let model: MoviesResponse = try await apiClient.performRequest(
            endpoint: MoviesEndpoint.getTopRated(language: language, page: page),
            decoder: JSONDecoder()
        )
        return model
    }

    func getUpcomingMovies(language: String, page: String) async throws -> MoviesResponse {
        let model: MoviesResponse = try await apiClient.performRequest(
            endpoint: MoviesEndpoint.getUpcoming(language: language, page: page),
            decoder: JSONDecoder()
        )
        return model
    }

    func getNowPlayingMovies(language: String, page: String) async throws -> MoviesResponse {
        let model: MoviesResponse = try await apiClient.performRequest(
            endpoint: MoviesEndpoint.getNowPlaying(language: language, page: page),
            decoder: JSONDecoder()
        )
        return model
    }

}

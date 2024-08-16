//
//  MoviesRepository.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

struct MoviesRepository: MoviesRepositoryProtocol {
    private var apiClient: APIClientProtocol = APIClient()
    private let session = URLSession(configuration: .default)
    
    func getPopularMovies(language: String, page: String) async throws -> PageableMoviesList {
        do {
            let response: MoviesResponse = try await apiClient.performRequest(
                endpoint: MoviesEndpoint.getPopular(language: language, page: page),
                decoder: JSONDecoder()
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func getTopRatedMovies(language: String, page: String) async throws -> MoviesList {
        do {
            let response: MoviesResponse = try await apiClient.performRequest(
                endpoint: MoviesEndpoint.getTopRated(language: language, page: page),
                decoder: JSONDecoder()
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func getUpcomingMovies(language: String, page: String) async throws -> MoviesList {
        do {
            let response: MoviesResponse = try await apiClient.performRequest(
                endpoint: MoviesEndpoint.getUpcoming(language: language, page: page),
                decoder: JSONDecoder()
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func getNowPlayingMovies(language: String, page: String) async throws -> MoviesList {
        do {
            let response: MoviesResponse = try await apiClient.performRequest(
                endpoint: MoviesEndpoint.getNowPlaying(language: language, page: page),
                decoder: JSONDecoder()
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func searchMovie(by query: String) async throws -> MoviesList {
        do {
            let response: MoviesResponse = try await apiClient.performRequest(
                endpoint: MoviesEndpoint.searchMovie(query: query),
                decoder: JSONDecoder()
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
}

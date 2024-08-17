//
//  MoviesRepository.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

struct MoviesRepository: MoviesRepositoryProtocol {
    private var apiClient: APIClientProtocol = APIClient()
    private var decoder = JSONDecoder()
    private let session = URLSession(configuration: .default)
    
    func getPopularMovies(language: String, page: String) async throws -> PageableMoviesList {
        do {
            let response: MoviesResponse = try await apiClient.fetchDataWithCacheCheck(
                endpoint: MoviesEndpoint.getPopular(language: language, page: page),
                decoder: decoder
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func getTopRatedMovies(language: String, page: String) async throws -> MoviesList {
        do {
            let response: MoviesResponse = try await apiClient.fetchDataWithCacheCheck(
                endpoint: MoviesEndpoint.getTopRated(language: language, page: page),
                decoder: decoder
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func getUpcomingMovies(language: String, page: String) async throws -> MoviesList {
        do {
            let response: MoviesResponse = try await apiClient.fetchDataWithCacheCheck(
                endpoint: MoviesEndpoint.getUpcoming(language: language, page: page),
                decoder: decoder
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func getNowPlayingMovies(language: String, page: String) async throws -> MoviesList {
        do {
            let response: MoviesResponse = try await apiClient.fetchDataWithCacheCheck(
                endpoint: MoviesEndpoint.getNowPlaying(language: language, page: page),
                decoder: decoder
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func searchMovie(by query: String) async throws -> MoviesList {
        do {
            let response: MoviesResponse = try await apiClient.fetchDataWithCacheCheck(
                endpoint: MoviesEndpoint.searchMovie(query: query),
                decoder: decoder
            )
            return response.asEntity()
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
    
    func getVideo(ofMovie id: Int, type: VideoType, site: VideoSite) async throws -> MovieVideoEntity {
        do {
            let response: MovieVideosResponse = try await apiClient.fetchDataWithCacheCheck(
                endpoint: MoviesEndpoint.getVideos(id: id),
                decoder: decoder
            )
            guard let entity = response.asEntity(type: type, site: site) else { throw DomainError.businessLogicFailed }
            return entity
        } catch {
            throw DomainError.businessLogicFailed
        }
    }
}

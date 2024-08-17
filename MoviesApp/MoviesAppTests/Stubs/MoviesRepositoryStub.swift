//
//  MoviesRepositoryStubs.swift
//  MoviesAppTests
//
//  Created by Javier Heisecke on 2024-08-17.
//

import Foundation
@testable import MoviesApp

struct MoviesRepositoryStub: MoviesRepositoryProtocol {
    
    var hasError = false
    
    func getPopularMovies(language: String, page: String) async throws -> MoviesApp.PageableMoviesList {
        if hasError {
            throw APIError.invalidResponse
        } else {
            return PageableMoviesList(movies: [MovieEntity(id: 1, title: "", description: nil, poster: nil, releaseDate: nil, voteAverage: nil, genres: nil)], hasNextPage: false)
        }
    }
    
    func getTopRatedMovies(language: String, page: String) async throws -> MoviesApp.MoviesList {
        if hasError {
            throw APIError.invalidResponse
        } else {
            return [MovieEntity(id: 1, title: "", description: nil, poster: nil, releaseDate: nil, voteAverage: nil, genres: nil)]
        }
    }
    
    func getUpcomingMovies(language: String, page: String) async throws -> MoviesApp.MoviesList {
        if hasError {
            throw APIError.invalidResponse
        } else {
            return [MovieEntity(id: 1, title: "", description: nil, poster: nil, releaseDate: nil, voteAverage: nil, genres: nil)]
        }
    }
    
    func getNowPlayingMovies(language: String, page: String) async throws -> MoviesApp.MoviesList {
        if hasError {
            throw APIError.invalidResponse
        } else {
            return [MovieEntity(id: 1, title: "", description: nil, poster: nil, releaseDate: nil, voteAverage: nil, genres: nil)]
        }
    }
    
    func searchMovie(by query: String) async throws -> MoviesApp.MoviesList {
        if hasError {
            throw APIError.invalidResponse
        } else {
            return [MovieEntity(id: 1, title: "", description: nil, poster: nil, releaseDate: nil, voteAverage: nil, genres: nil)]
        }
    }
    
    func getVideo(ofMovie id: Int, type: MoviesApp.VideoType, site: MoviesApp.VideoSite) async throws -> MoviesApp.MovieVideoEntity {
        if hasError {
            throw APIError.invalidResponse
        } else {
            return MovieVideoEntity(id: "1", name: "", site: .youTube, videoType: .trailer, key: "dd")
        }
    }
    
    
}

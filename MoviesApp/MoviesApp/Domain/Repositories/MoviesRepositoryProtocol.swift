//
//  MoviesRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func getPopularMovies(language: String, page: String) async throws -> MoviesResponse
    func getTopRatedMovies(language: String, page: String) async throws -> MoviesResponse
    func getUpcomingMovies(language: String, page: String) async throws -> MoviesResponse
    func getNowPlayingMovies(language: String, page: String) async throws -> MoviesResponse
}

//
//  MoviesRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func getPopularMovies(language: String, page: String, size: PosterSize) async throws -> PageableMoviesList
    func getTopRatedMovies(language: String, page: String, size: PosterSize) async throws -> MoviesList
    func getUpcomingMovies(language: String, page: String, size: PosterSize) async throws -> MoviesList
    func getNowPlayingMovies(language: String, page: String, size: PosterSize) async throws -> MoviesList
}

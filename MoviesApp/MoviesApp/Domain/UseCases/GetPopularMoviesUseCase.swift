//
//  GetPopularMoviesUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

protocol GetPopularMoviesUseCaseProtocol {
    func get(page: String) async throws -> PageableMoviesList
}

struct GetPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol {
    
    private let moviesRepository: MoviesRepositoryProtocol

    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }

    func get(page: String) async throws -> PageableMoviesList {
        return try await moviesRepository.getPopularMovies(language: "en", page: page, size: .medium)
    }
}

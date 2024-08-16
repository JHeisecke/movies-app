//
//  GetTopRatedMoviesUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

protocol GetTopRatedMoviesUseCaseProtocol {
    func get(page: String) async throws -> MoviesList
}

struct GetTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol {
    
    private let moviesRepository: MoviesRepositoryProtocol

    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }

    func get(page: String) async throws -> MoviesList {
        return try await moviesRepository.getTopRatedMovies(language: "en", page: page)
    }
}

//
//  SearchMoviesUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol SearchMoviesUseCaseProtocol {
    func get(query: String) async throws -> MoviesList
}

struct SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    
    private let moviesRepository: MoviesRepositoryProtocol

    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }

    func get(query: String) async throws -> MoviesList {
        return try await moviesRepository.searchMovie(by: query)
    }
}

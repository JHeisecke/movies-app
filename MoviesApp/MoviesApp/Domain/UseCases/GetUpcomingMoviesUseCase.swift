//
//  GetUpcominMoviesUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

protocol GetUpcomingMoviesUseCaseProtocol {
    func get(page: String) async throws -> MoviesList
}

struct GetUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol {
    
    private let moviesRepository: MoviesRepositoryProtocol

    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }

    func get(page: String) async throws -> MoviesList {
        return try await moviesRepository.getUpcomingMovies(language: "en", page: page, size: .small)
    }
}

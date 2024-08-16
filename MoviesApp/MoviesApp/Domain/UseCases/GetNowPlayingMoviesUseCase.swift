//
//  GetNowPlayingMoviesUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

protocol GetNowPlayingMoviesUseCaseProtocol {
    func get(page: String) async throws -> MoviesList
}

struct GetNowPlayingMoviesUseCase: GetNowPlayingMoviesUseCaseProtocol {
    
    private let moviesRepository: MoviesRepositoryProtocol

    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }

    func get(page: String) async throws -> MoviesList {
        return try await moviesRepository.getNowPlayingMovies(language: "en", page: page, size: .small)
    }
}


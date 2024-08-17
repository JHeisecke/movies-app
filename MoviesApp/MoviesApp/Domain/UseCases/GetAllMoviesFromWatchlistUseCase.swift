//
//  GetAllMoviesFromWatchlistUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol GetAllMoviesFromWatchlistUseCaseProtocol {
    func get() async throws -> MoviesList
}

struct GetAllMoviesFromWatchlistUseCase: GetAllMoviesFromWatchlistUseCaseProtocol {
    
    private let watchlistRespository: WatchlistRepositoryProtocol

    init(watchlistRespository: WatchlistRepositoryProtocol) {
        self.watchlistRespository = watchlistRespository
    }

    func get() async throws -> MoviesList {
        return try await watchlistRespository.getAll()
    }
}

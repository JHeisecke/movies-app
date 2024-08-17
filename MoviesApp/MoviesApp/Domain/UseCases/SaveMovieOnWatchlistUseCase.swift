//
//  SaveMovieOnWatchlistUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol SaveMovieOnWatchlistUseCaseProtocol {
    func execute(entity: MovieEntity) async throws -> Bool
}

struct SaveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol {
    
    private let watchlistRespository: WatchlistRepositoryProtocol

    init(watchlistRespository: WatchlistRepositoryProtocol) {
        self.watchlistRespository = watchlistRespository
    }

    func execute(entity: MovieEntity) async throws -> Bool {
        return try await watchlistRespository.store(movie: entity)
    }
}

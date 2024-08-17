//
//  SaveMovieOnWatchlistUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol SaveMovieOnWatchlistUseCaseProtocol {
    func execute(entity: MovieEntity) async -> Bool
}

struct SaveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol {
    
    private let watchlistRepository: WatchlistRepositoryProtocol

    init(watchlistRepository: WatchlistRepositoryProtocol) {
        self.watchlistRepository = watchlistRepository
    }

    func execute(entity: MovieEntity) async -> Bool {
        return await watchlistRepository.store(movie: entity)
    }
}

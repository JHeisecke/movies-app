//
//  GetAllMoviesFromWatchlistUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol GetAllMoviesFromWatchlistUseCaseProtocol {
    func get() async -> MoviesList?
}

struct GetAllMoviesFromWatchlistUseCase: GetAllMoviesFromWatchlistUseCaseProtocol {
    
    private let watchlistRepository: WatchlistRepositoryProtocol

    init(watchlistRepository: WatchlistRepositoryProtocol) {
        self.watchlistRepository = watchlistRepository
    }

    func get() async -> MoviesList? {
        do {
            return try await watchlistRepository.getAll()
        } catch {
            return nil
        }
    }
}

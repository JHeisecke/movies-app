//
//  RemoveMovieFromWatchlistUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol RemoveMovieFromWatchlistUseCaseProtocol {
    func delete(id: Int) async throws -> Bool
}

struct RemoveMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol {
    
    private let watchlistRepository: WatchlistRepositoryProtocol

    init(watchlistRepository: WatchlistRepositoryProtocol) {
        self.watchlistRepository = watchlistRepository
    }

    func delete(id: Int) async throws -> Bool {
        return try await watchlistRepository.delete(by: id)
    }
}

//
//  RemoveMovieFromWatchlistUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol RemoveMovieFromWatchlistUseCaseProtocol {
    func delete(id: Int) async -> Bool
}

struct RemoveMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol {
    
    private let watchlistRepository: WatchlistRepositoryProtocol

    init(watchlistRepository: WatchlistRepositoryProtocol) {
        self.watchlistRepository = watchlistRepository
    }

    func delete(id: Int) async -> Bool {
        do {
            return try await watchlistRepository.delete(by: id)
        } catch {
            return false
        }
    }
}

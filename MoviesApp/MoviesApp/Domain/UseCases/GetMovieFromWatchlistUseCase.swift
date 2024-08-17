//
//  GetMovieFromWatchlistUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol GetMovieFromWatchlistUseCaseProtocol {
    func get(by id: Int) async -> MovieEntity?
}

struct GetMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCaseProtocol {
    
    private let watchlistRepository: WatchlistRepositoryProtocol

    init(watchlistRepository: WatchlistRepositoryProtocol) {
        self.watchlistRepository = watchlistRepository
    }

    func get(by id: Int) async -> MovieEntity? {
        do {
            return try await watchlistRepository.get(by: id)
        } catch {
            return nil
        }
    }
}

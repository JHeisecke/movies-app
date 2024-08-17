//
//  WatchlistViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

@MainActor
final class WatchlistViewModel: ObservableObject {
    
    // MARK: - Types
    
    enum MoviesState {
        case loading
        case error
        case empty
        case data(movies: MoviesList)
    }
    
    // MARK: - Properties
    
    @Published private(set) var movies: MoviesState = .empty
    
    private let getVideoUseCase: GetVideoUseCaseProtocol
    private let getWatchlistMoviesUseCase: GetAllMoviesFromWatchlistUseCaseProtocol
    private let saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol
    private let removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol
    private let getMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCaseProtocol
    
    func movieDetailViewModel(movie: MovieEntity) -> MovieDetailViewModel {
        .init(movie: movie, getVideoUseCase: getVideoUseCase, removeMovieFromWatchlistUseCase: removeMovieFromWatchlistUseCase, saveMovieOnWatchlistUseCase: saveMovieOnWatchlistUseCase, getMovieFromWatchlistUseCase: getMovieFromWatchlistUseCase)
    }
    
    // MARK: - Initialization
    
    init(getVideoUseCase: GetVideoUseCaseProtocol, getWatchlistMoviesUseCase: GetAllMoviesFromWatchlistUseCaseProtocol, saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol, removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol, getMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCaseProtocol) {
        self.getVideoUseCase = getVideoUseCase
        self.getWatchlistMoviesUseCase = getWatchlistMoviesUseCase
        self.saveMovieOnWatchlistUseCase = saveMovieOnWatchlistUseCase
        self.removeMovieFromWatchlistUseCase = removeMovieFromWatchlistUseCase
        self.getMovieFromWatchlistUseCase = getMovieFromWatchlistUseCase
    }
    
    func removeFromWatchlist(_ movie: MovieEntity) async {
        let result = await removeMovieFromWatchlistUseCase.delete(id: movie.id)
        if result {
            guard case .data(var watchlistMovies) = movies else { return }
            watchlistMovies.removeAll(where: { $0.id == movie.id })
            if watchlistMovies.isEmpty {
                movies = .empty
            } else {
                movies = .data(movies: watchlistMovies)
            }
        }
    }
    
    func getAllWatchlistMovies() async {
        guard let result = await getWatchlistMoviesUseCase.get() else {
            movies = .error
            return
        }
        guard !result.isEmpty else {
            movies = .empty
            return
        }
        movies = .data(movies: result)
    }
}

//
//  MainViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

@MainActor
final class MainViewModel {
    private let movieRepository: MoviesRepositoryProtocol
    private let watchlistRepository: WatchlistRepositoryProtocol
    private let getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol
    private let getUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol
    private let getNowPlayingMoviesUseCase: GetNowPlayingMoviesUseCaseProtocol
    private let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    private let getVideoUseCase: GetVideoUseCaseProtocol
    private let searchMoviesUseCase: SearchMoviesUseCaseProtocol
    private let getWatchlistMoviesUseCase: GetAllMoviesFromWatchlistUseCaseProtocol
    private let saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol
    private let removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol
    
    init(movieRepository: MoviesRepositoryProtocol, watchlistRepository: WatchlistRepositoryProtocol) {
        self.movieRepository = movieRepository
        self.watchlistRepository = watchlistRepository
        self.getPopularMoviesUseCase = GetPopularMoviesUseCase(moviesRepository: movieRepository)
        self.getUpcomingMoviesUseCase = GetUpcomingMoviesUseCase(moviesRepository: movieRepository)
        self.getNowPlayingMoviesUseCase = GetNowPlayingMoviesUseCase(moviesRepository: movieRepository)
        self.getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(moviesRepository: movieRepository)
        self.getVideoUseCase = GetVideoUseCase(moviesRepository: movieRepository)
        self.searchMoviesUseCase = SearchMoviesUseCase(moviesRepository: movieRepository)
        self.getWatchlistMoviesUseCase = GetAllMoviesFromWatchlistUseCase(watchlistRepository: watchlistRepository)
        self.saveMovieOnWatchlistUseCase = SaveMovieOnWatchlistUseCase(watchlistRepository: watchlistRepository)
        self.removeMovieFromWatchlistUseCase = RemoveMovieFromWatchlistUseCase(watchlistRepository: watchlistRepository)
    }
    
    var homeViewModel: HomeViewModel {
        .init(getPopularUseCase: getPopularMoviesUseCase, getUpcomingUseCase: getUpcomingMoviesUseCase, getTopRatedUseCase: getTopRatedMoviesUseCase, getNowPlayingUseCase: getNowPlayingMoviesUseCase, getVideoUseCase: getVideoUseCase, removeMovieFromWatchlistUseCase: removeMovieFromWatchlistUseCase, saveMovieOnWatchlistUseCase: saveMovieOnWatchlistUseCase)
    }
    
    var searchViewModel: SearchViewModel {
        .init(searchUseCase: searchMoviesUseCase, getVideoUseCase: getVideoUseCase, debouncer: Debouncer(delay: 1), saveMovieOnWatchlistUseCase: saveMovieOnWatchlistUseCase, removeMovieFromWatchlistUseCase: removeMovieFromWatchlistUseCase)
    }
    
    var watchlistViewModel: WatchlistViewModel {
        .init(getVideoUseCase: getVideoUseCase, getWatchlistMoviesUseCase: getWatchlistMoviesUseCase, saveMovieOnWatchlistUseCase: saveMovieOnWatchlistUseCase, removeMovieFromWatchlistUseCase: removeMovieFromWatchlistUseCase)
    }
}

//
//  MainViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

@MainActor
final class MainViewModel {
    let movieRepository: MoviesRepositoryProtocol
    let watchlistRepository: WatchlistRepositoryProtocol
    let getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol
    let getUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol
    let getNowPlayingMoviesUseCase: GetNowPlayingMoviesUseCaseProtocol
    let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    let getVideoUseCase: GetVideoUseCaseProtocol
    let searchMoviesUseCase: SearchMoviesUseCaseProtocol
    let getWatchlistMoviesUseCase: GetAllMoviesFromWatchlistUseCaseProtocol
    
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
    }
    
    var homeViewModel: HomeViewModel {
        .init(getPopularUseCase: getPopularMoviesUseCase, getUpcomingUseCase: getUpcomingMoviesUseCase, getTopRatedUseCase: getTopRatedMoviesUseCase, getNowPlayingUseCase: getNowPlayingMoviesUseCase, getVideoUseCase: getVideoUseCase)
    }
    
    var searchViewModel: SearchViewModel {
        .init(searchUseCase: searchMoviesUseCase, getVideoUseCase: getVideoUseCase, debouncer: Debouncer(delay: 1))
    }
    
    var watchlistViewModel: WatchlistViewModel {
        .init(getVideoUseCase: getVideoUseCase, getWatchlistMoviesUseCase: getWatchlistMoviesUseCase)
    }
}

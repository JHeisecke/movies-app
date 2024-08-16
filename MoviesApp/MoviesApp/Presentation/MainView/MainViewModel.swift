//
//  MainViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

@MainActor
final class MainViewModel {
    var homeViewModel: HomeViewModel {
        .init(getPopularUseCase: GetPopularMoviesUseCase(moviesRepository: MoviesRepository()), getUpcomingUseCase: GetUpcomingMoviesUseCase(moviesRepository: MoviesRepository()), getTopRatedUseCase: GetTopRatedMoviesUseCase(moviesRepository: MoviesRepository()), getNowPlayingUseCase: GetNowPlayingMoviesUseCase(moviesRepository: MoviesRepository()))
    }
    
    var searchViewModel: SearchViewModel {
        .init(searchUseCase: SearchMoviesUseCase(moviesRepository: MoviesRepository()), debouncer: Debouncer(delay: 1))
    }
}

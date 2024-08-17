//
//  MainViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

@MainActor
final class MainViewModel {
    let movieRepository = MoviesRepository()
    
    var homeViewModel: HomeViewModel {
        .init(getPopularUseCase: GetPopularMoviesUseCase(moviesRepository: movieRepository), getUpcomingUseCase: GetUpcomingMoviesUseCase(moviesRepository: movieRepository), getTopRatedUseCase: GetTopRatedMoviesUseCase(moviesRepository: movieRepository), getNowPlayingUseCase: GetNowPlayingMoviesUseCase(moviesRepository: movieRepository), getVideoUseCase: GetVideoUseCase(moviesRepository: movieRepository))
    }
    
    var searchViewModel: SearchViewModel {
        .init(searchUseCase: SearchMoviesUseCase(moviesRepository: movieRepository), getVideoUseCase: GetVideoUseCase(moviesRepository: movieRepository), debouncer: Debouncer(delay: 1))
    }
}

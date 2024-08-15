//
//  MainViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

final class MainViewModel {
    var homeViewModel: HomeViewModel {
        .init(getPopularUseCase: GetPopularMoviesUseCase(moviesRepository: MoviesRepository()), getUpcomingUseCase: GetUpcomingMoviesUseCase(moviesRepository: MoviesRepository()), getTopRatedUseCase: GetTopRatedMoviesUseCase(moviesRepository: MoviesRepository()), getNowPlayingUseCase: GetNowPlayingMoviesUseCase(moviesRepository: MoviesRepository()))
    }
}

//
//  HomeViewModelTests.swift
//  MoviesAppTests
//
//  Created by Javier Heisecke on 2024-08-17.
//

import XCTest
@testable import MoviesApp

@MainActor
final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var moviesRepository: MoviesRepositoryStub!
    var getPopularUseCase: GetPopularMoviesUseCaseProtocol!
    var getUpcomingUseCase: GetUpcomingMoviesUseCaseProtocol!
    var getTopRatedUseCase: GetTopRatedMoviesUseCaseProtocol!
    var getNowPlayingUseCase: GetNowPlayingMoviesUseCaseProtocol!
    var getVideoUseCase: GetVideoUseCaseProtocol!
    var saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol!
    var removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol!
    var getMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCaseProtocol!

    override func setUp() {
        super.setUp()
        moviesRepository = MoviesRepositoryStub()
        let watchlistRepository = WatchlistRepository()
        getPopularUseCase = GetPopularMoviesUseCase(moviesRepository: moviesRepository)
        getUpcomingUseCase = GetUpcomingMoviesUseCase(moviesRepository: moviesRepository)
        getTopRatedUseCase = GetTopRatedMoviesUseCase(moviesRepository: moviesRepository)
        getNowPlayingUseCase = GetNowPlayingMoviesUseCase(moviesRepository: moviesRepository)
        getVideoUseCase = GetVideoUseCase(moviesRepository: moviesRepository)
        saveMovieOnWatchlistUseCase = SaveMovieOnWatchlistUseCase(watchlistRepository: watchlistRepository)
        removeMovieFromWatchlistUseCase = RemoveMovieFromWatchlistUseCase(watchlistRepository: watchlistRepository)
        getMovieFromWatchlistUseCase = GetMovieFromWatchlistUseCase(watchlistRepository: watchlistRepository)
    }

    override func tearDown() {
        viewModel = nil
        moviesRepository = nil
        getPopularUseCase = nil
        getUpcomingUseCase = nil
        getTopRatedUseCase = nil
        getNowPlayingUseCase = nil
        getVideoUseCase = nil
        saveMovieOnWatchlistUseCase = nil
        removeMovieFromWatchlistUseCase = nil
        getMovieFromWatchlistUseCase = nil
        super.tearDown()
    }

    func testGetPopularMoviesSuccess() async {
        Task {
            moviesRepository.hasError = false
            await viewModel.getPopularMovies()
            XCTAssertEqual(viewModel.popularMovies, .data(movies: PageableMoviesList(movies: [MovieEntity(id: 1, title: "", description: nil, poster: nil, releaseDate: nil, voteAverage: nil, genres: nil)], hasNextPage: false)))
            XCTAssertFalse(viewModel.currentlyFetching)
        }
    }
}

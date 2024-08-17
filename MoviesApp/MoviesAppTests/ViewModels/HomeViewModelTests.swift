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
        viewModel = HomeViewModel(getPopularUseCase: getPopularUseCase,
                                  getUpcomingUseCase: getUpcomingUseCase,
                                  getTopRatedUseCase: getTopRatedUseCase,
                                  getNowPlayingUseCase: getNowPlayingUseCase,
                                  getVideoUseCase: getVideoUseCase,
                                  removeMovieFromWatchlistUseCase: removeMovieFromWatchlistUseCase,
                                  saveMovieOnWatchlistUseCase: saveMovieOnWatchlistUseCase,
                                  getMovieFromWatchlistUseCase: getMovieFromWatchlistUseCase)
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
        moviesRepository.hasError = false
        await viewModel.getPopularMovies()
        XCTAssertEqual(viewModel.popularMovies, .data(movies: PageableMoviesList(movies: [MovieEntity(id: 1, title: "", description: nil, poster: nil, releaseDate: nil, voteAverage: nil, genres: nil)], hasNextPage: false)))
        XCTAssertFalse(viewModel.currentlyFetching)
    }

    func testGetPopularMoviesError() async {
        moviesRepository.hasError = true
        await viewModel.getPopularMovies()
        XCTAssertEqual(viewModel.popularMovies, .error)
        XCTAssertFalse(viewModel.currentlyFetching)
    }

    func testGetUpcomingMoviesSuccess() async {
        moviesRepository.hasError = false
        await viewModel.getUpcomingMovies()
        XCTAssertEqual(viewModel.upcomingMovies.count, 1)
        XCTAssertEqual(viewModel.upcomingMovies.first?.id, 1)
    }

    func testGetUpcomingMoviesError() async {
        moviesRepository.hasError = true
        await viewModel.getUpcomingMovies()
        XCTAssertTrue(viewModel.upcomingMovies.isEmpty)
    }

    func testGetTopRatedMoviesSuccess() async {
        moviesRepository.hasError = false
        await viewModel.getTopRatedMovies()
        XCTAssertEqual(viewModel.topRatedMovies.count, 1)
        XCTAssertEqual(viewModel.topRatedMovies.first?.id, 1)
    }

    func testGetTopRatedMoviesError() async {
        moviesRepository.hasError = true
        await viewModel.getTopRatedMovies()
        XCTAssertTrue(viewModel.topRatedMovies.isEmpty)
    }

    func testGetNowPlayingMoviesSuccess() async {
        moviesRepository.hasError = false
        await viewModel.getNowPlayingMovies()
        XCTAssertEqual(viewModel.nowPlayingMovies.count, 1)
        XCTAssertEqual(viewModel.nowPlayingMovies.first?.id, 1)
    }

    func testGetNowPlayingMoviesError() async {
        moviesRepository.hasError = true
        await viewModel.getNowPlayingMovies()
        XCTAssertTrue(viewModel.nowPlayingMovies.isEmpty)
    }

    func testGetNextPage() async {
        await viewModel.getPopularMovies()
        await viewModel.getNextPage()
        XCTAssertEqual(viewModel.page, 2)
    }

    func testCategoryChange() async {
        await viewModel.getNowPlayingMovies()
        viewModel.categoryChange(.nowPlaying)
        XCTAssertEqual(viewModel.categorySelectedMovies, viewModel.nowPlayingMovies)
    }
}

//
//  SearchViewModelTests.swift
//  MoviesAppTests
//
//  Created by Javier Heisecke on 2024-08-17.
//

import XCTest
@testable import MoviesApp

@MainActor
final class SearchViewModelTests: XCTestCase {

    var moviesRepository: MoviesRepositoryStub!
    var viewModel: SearchViewModel!
    var searchUseCase: SearchMoviesUseCaseProtocol!
    var getVideoUseCase: GetVideoUseCaseProtocol!
    var saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol!
    var removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol!
    var getMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCaseProtocol!
    var debouncer: Debouncer!

    override func setUp() {
        super.setUp()
        moviesRepository = MoviesRepositoryStub()
        searchUseCase = SearchMoviesUseCase(moviesRepository: moviesRepository)
        getVideoUseCase = GetVideoUseCase(moviesRepository: moviesRepository)
        saveMovieOnWatchlistUseCase = SaveMovieOnWatchlistUseCase(watchlistRepository: WatchlistRepository())
        removeMovieFromWatchlistUseCase = RemoveMovieFromWatchlistUseCase(watchlistRepository: WatchlistRepository())
        getMovieFromWatchlistUseCase = GetMovieFromWatchlistUseCase(watchlistRepository: WatchlistRepository())
        debouncer = Debouncer(delay: 1)
        viewModel = SearchViewModel(
            searchUseCase: searchUseCase,
            getVideoUseCase: getVideoUseCase,
            debouncer: debouncer,
            saveMovieOnWatchlistUseCase: saveMovieOnWatchlistUseCase,
            removeMovieFromWatchlistUseCase: removeMovieFromWatchlistUseCase,
            getMovieFromWatchlistUseCase: getMovieFromWatchlistUseCase
        )
    }

    override func tearDown() {
        viewModel = nil
        searchUseCase = nil
        getVideoUseCase = nil
        saveMovieOnWatchlistUseCase = nil
        removeMovieFromWatchlistUseCase = nil
        getMovieFromWatchlistUseCase = nil
        debouncer = nil
        super.tearDown()
    }

    func testSearchTextEmpty() {
        viewModel.searchText = ""
        XCTAssertEqual(viewModel.searchStatus, .loading)
    }

    func testSearchTextNotEmptyTriggersSearch() {
        let expectation = XCTestExpectation(description: "Search triggered")
        debouncer.call {
            expectation.fulfill()
        }
        viewModel.searchText = "Inception"
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMoviesSuccess() {
        viewModel.getMovies()
        XCTAssertEqual(viewModel.searchStatus, .data(movies: [MovieEntity(id: 1, title: "", description: nil, poster: nil, releaseDate: nil, voteAverage: nil, genres: nil)]))
    }

    func testGetMoviesFailure() {
        moviesRepository.hasError = true
        viewModel.getMovies()
        XCTAssertEqual(viewModel.searchStatus, .empty)
    }
}

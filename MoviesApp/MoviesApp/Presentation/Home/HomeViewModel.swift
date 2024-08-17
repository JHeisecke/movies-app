//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Types
    enum PopularMoviesState {
        case loading
        case data(movies: PageableMoviesList)
        case error
    }
    
    struct Constants {
        static let moviesLimitConstant = 6
    }
    
    // MARK: - Properties

    var page: Int = 1
    var hasNextPage = false
    var currentlyFetching = false
    @Published var popularMovies: PopularMoviesState = .loading
    @Published var categorySelectedMovies: MoviesList = []
    var topRatedMovies: MoviesList = []
    var upcomingMovies: MoviesList = []
    var nowPlayingMovies: MoviesList = []
    
    private let getPopularUseCase: GetPopularMoviesUseCaseProtocol
    private let getUpcomingUseCase: GetUpcomingMoviesUseCaseProtocol
    private let getTopRatedUseCase: GetTopRatedMoviesUseCaseProtocol
    private let getNowPlayingUseCase: GetNowPlayingMoviesUseCaseProtocol
    private let getVideoUseCase: GetVideoUseCaseProtocol
    private let saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol
    private let removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol
    
    func movieDetailViewModel(movie: MovieEntity) -> MovieDetailViewModel {
        .init(movie: movie, getVideoUseCase: getVideoUseCase, removeMovieFromWatchlistUseCase: removeMovieFromWatchlistUseCase, saveMovieOnWatchlistUseCase: saveMovieOnWatchlistUseCase)
    }
    
    // MARK: - Initialization
    
    init(getPopularUseCase: GetPopularMoviesUseCaseProtocol,
         getUpcomingUseCase: GetUpcomingMoviesUseCaseProtocol,
         getTopRatedUseCase: GetTopRatedMoviesUseCaseProtocol,
         getNowPlayingUseCase: GetNowPlayingMoviesUseCaseProtocol,
         getVideoUseCase: GetVideoUseCaseProtocol,
         removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol,
         saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol) {
        self.getPopularUseCase = getPopularUseCase
        self.getUpcomingUseCase = getUpcomingUseCase
        self.getTopRatedUseCase = getTopRatedUseCase
        self.getNowPlayingUseCase = getNowPlayingUseCase
        self.removeMovieFromWatchlistUseCase = removeMovieFromWatchlistUseCase
        self.saveMovieOnWatchlistUseCase = saveMovieOnWatchlistUseCase
        self.getVideoUseCase = getVideoUseCase
    }
    
    func onAppear() async {
        await getAll()
        categorySelectedMovies = nowPlayingMovies
    }
    
    func getAll() async {
        await getPopularMovies()
        await getNowPlayingMovies()
        await getTopRatedMovies()
        await getUpcomingMovies()
    }
    
    // MARK: - API
    
    func getPopularMovies() async {
        guard !currentlyFetching else { return }
        currentlyFetching = true
        
        defer {
            currentlyFetching = false
        }
        
        do {
            let response = try await getPopularUseCase.get(page: "\(page)")
            if case .data(var currentMovies) = popularMovies {
                currentMovies.movies.append(contentsOf: response.movies)
                popularMovies = .data(movies: currentMovies)
                return
            }
            popularMovies = .data(movies: response)
        } catch {
            currentlyFetching = false
        }
    }

    func getNowPlayingMovies() async {
        do {
            let movies = try await getNowPlayingUseCase.get(page: "\(1)")
            nowPlayingMovies = Array(movies.prefix(Constants.moviesLimitConstant))
        } catch {
            nowPlayingMovies = []
        }
    }

    func getUpcomingMovies() async {
        do {
            let movies = try await getUpcomingUseCase.get(page: "\(1)")
            upcomingMovies = Array(movies.prefix(Constants.moviesLimitConstant))
        } catch {
            upcomingMovies = []
        }
    }

    func getTopRatedMovies() async {
        do {
            let movies = try await getTopRatedUseCase.get(page: "\(1)")
            topRatedMovies = Array(movies.prefix(Constants.moviesLimitConstant))
        } catch {
            topRatedMovies = []
        }
    }
    
    
    // MARK: - Actions
    
    func getNextPage() async {
        guard case .data(let movies) = popularMovies, movies.hasNextPage else { return }
        page += 1
        await getPopularMovies()
        
    }
    
    func categoryChange(_ selectedTab: MovieCategory) {
        switch selectedTab {
        case .nowPlaying:
            categorySelectedMovies = nowPlayingMovies
        case .upcoming:
            categorySelectedMovies = upcomingMovies
        case .topRated:
            categorySelectedMovies = topRatedMovies
        default:
            return
        }
    }
}

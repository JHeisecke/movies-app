//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    // MARK: - Types
    enum PopularMoviesState {
        case loading
        case data(movies: PageableMoviesList)
        case error
    }
    
    // MARK: - Properties

    var page: Int = 1
    @Published var popularMovies: PopularMoviesState = .loading
    @Published var topRatedMovies: MoviesList = []
    @Published var upcomingMovies: MoviesList = []
    @Published var nowPlayingMovies: MoviesList = []
    
    private let getPopularUseCase: GetPopularMoviesUseCaseProtocol
    private let getUpcomingUseCase: GetUpcomingMoviesUseCaseProtocol
    private let getTopRatedUseCase: GetTopRatedMoviesUseCaseProtocol
    private let getNowPlayingUseCase: GetNowPlayingMoviesUseCaseProtocol

    // MARK: - Initialization
    
    init(getPopularUseCase: GetPopularMoviesUseCaseProtocol,
         getUpcomingUseCase: GetUpcomingMoviesUseCaseProtocol,
         getTopRatedUseCase: GetTopRatedMoviesUseCaseProtocol,
         getNowPlayingUseCase: GetNowPlayingMoviesUseCaseProtocol) {
        self.getPopularUseCase = getPopularUseCase
        self.getUpcomingUseCase = getUpcomingUseCase
        self.getTopRatedUseCase = getTopRatedUseCase
        self.getNowPlayingUseCase = getNowPlayingUseCase
    }
    
    @MainActor
    func onAppear() async {
        do {
            let movies = try await getPopularUseCase.get(page: "\(page)")
            popularMovies = .data(movies: movies)
        } catch {
            popularMovies = .error
        }
    }
    
    // MARK: - Actions
    
    func categoryChange(_ selectedTab: MovieCategory) {
        switch selectedTab {
        case .nowPlaying:
            print("")
        case .upcoming:
            print("")
        case .topRated:
            print("")
        default:
            return
        }
    }
}

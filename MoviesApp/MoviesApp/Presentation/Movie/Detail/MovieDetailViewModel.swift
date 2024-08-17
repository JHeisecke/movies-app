//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    
    // MARK: - Types
    
    enum BookmarkState {
        case loading
        case error(saved: Bool)
        case done(saved: Bool)
        case none
    }
    
    // MARK: - Properties
    
    private(set) var movie: MovieEntity
    @Published private(set) var video: MovieVideoEntity?
    @Published private(set) var bookmarkState: BookmarkState = .none
    @Published private(set) var isBookmarked = false
    
    private let getVideoUseCase: GetVideoUseCaseProtocol
    private let saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol
    private let removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol
    private let getMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCaseProtocol
    
    // MARK: - Initialization
    
    init(movie: MovieEntity, getVideoUseCase: GetVideoUseCaseProtocol, removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol, saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol, getMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCaseProtocol) {
        self.movie = movie
        self.getVideoUseCase = getVideoUseCase
        self.saveMovieOnWatchlistUseCase = saveMovieOnWatchlistUseCase
        self.getMovieFromWatchlistUseCase = getMovieFromWatchlistUseCase
        self.removeMovieFromWatchlistUseCase = removeMovieFromWatchlistUseCase
    }
    
    // MARK: - API
    
    func getVideo() async {
        do {
            video = try await getVideoUseCase.get(id: movie.id, type: .trailer, site: .youTube)
        } catch {
            video = nil
        }
    }
    
    func checkIfMovieIsOnWatchlist() async {
        guard await getMovieFromWatchlistUseCase.get(by: movie.id) != nil else {
            isBookmarked = false
            return
        }
        isBookmarked = true
    }
    
    func saveOnWatchlist() async {
        if case .loading = bookmarkState { return }
        bookmarkState = .loading
        let result = await saveMovieOnWatchlistUseCase.execute(entity: movie)
        if result {
            bookmarkState = .done(saved: true)
            isBookmarked = true
        } else {
            bookmarkState = .error(saved: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.bookmarkState = .none
        }
    }
    
    func removeFromWatchlist() async {
        if case .loading = bookmarkState { return }
        bookmarkState = .loading
        let result = await removeMovieFromWatchlistUseCase.delete(id: movie.id)
        if result {
            bookmarkState = .done(saved: false)
            isBookmarked = false
        } else {
            bookmarkState = .error(saved: false)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.bookmarkState = .none
        }
    }
}

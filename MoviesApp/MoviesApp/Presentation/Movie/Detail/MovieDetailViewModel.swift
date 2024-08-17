//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private(set) var movie: MovieEntity
    @Published private(set) var video: MovieVideoEntity?
    private let getVideoUseCase: GetVideoUseCaseProtocol
    private let saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol
    private let removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol
    
    // MARK: - Initialization
    
    init(movie: MovieEntity, getVideoUseCase: GetVideoUseCaseProtocol, removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCaseProtocol, saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCaseProtocol) {
        self.movie = movie
        self.getVideoUseCase = getVideoUseCase
        self.saveMovieOnWatchlistUseCase = saveMovieOnWatchlistUseCase
        self.removeMovieFromWatchlistUseCase = removeMovieFromWatchlistUseCase
    }
    
    func getVideo() async {
        do {
            video = try await getVideoUseCase.get(id: movie.id, type: .trailer, site: .youTube)
        } catch {
            video = nil
        }
    }
}

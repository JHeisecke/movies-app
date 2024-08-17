//
//  WatchlistViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

@MainActor
final class WatchlistViewModel: ObservableObject {
    
    // MARK: - Types
    
    enum MoviesState {
        case loading
        case empty
        case data(movies: MoviesList)
    }
    
    // MARK: - Properties
    
    @Published private(set) var movies: MoviesState = .empty
    
    private let getVideoUseCase: GetVideoUseCaseProtocol
    
    func movieDetailViewModel(movie: MovieEntity) -> MovieDetailViewModel {
        .init(movie: movie, getVideoUseCase: getVideoUseCase)
    }
    
    // MARK: - Initialization
    
    init(getVideoUseCase: GetVideoUseCaseProtocol) {
        self.getVideoUseCase = getVideoUseCase
    }
}

//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {

    // MARK: - Types
    enum SearchStatus {
        case loading
        case empty
        case data(movies: MoviesList)
    }
    
    // MARK: - Properties

    @Published var searchText: String = "" {
        didSet {
            guard !searchText.isEmpty else {
                debouncer.cancel()
                searchStatus = .loading
                return
            }
            debouncer.call { [weak self] in
                self?.getMovies()
            }
        }
    }
    @Published private(set) var searchStatus: SearchStatus = .loading
    
    private let searchUseCase: SearchMoviesUseCaseProtocol
    private let getVideoUseCase: GetVideoUseCaseProtocol
    let debouncer: Debouncer
    
    func movieDetailViewModel(movie: MovieEntity) -> MovieDetailViewModel {
        .init(movie: movie, getVideoUseCase: getVideoUseCase)
    }
    
    // MARK: - Initialization
    
    init(searchUseCase: SearchMoviesUseCaseProtocol, getVideoUseCase: GetVideoUseCaseProtocol, debouncer: Debouncer) {
        self.searchUseCase = searchUseCase
        self.getVideoUseCase = getVideoUseCase
        self.debouncer = debouncer
    }
    
    // MARK: - API
    
    func getMovies() {
        Task {
            do {
                let response = try await searchUseCase.get(query: searchText)
                if response.isEmpty {
                    searchStatus = .empty
                    return
                }
                searchStatus = .data(movies: response)
            } catch {
                searchStatus = .empty
            }
        }
    }
}

//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

final class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var searchedMovies: MoviesList = []
}

//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var popularMovies = ""
    
    // MARK: - Initialization
    
    
    // MARK: - Actions
    
    func categoryChange(_ selectedTab: CategoriesView.Tab) {
        switch selectedTab {
        case .nowPlaying:
            print("")
        case .upcoming:
            print("")
        case .topRated:
            print("")
        }
    }
}

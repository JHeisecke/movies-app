//
//  MovieCategory.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

enum MovieCategory: Int, Identifiable {
    internal var id: Int { rawValue }
    
    case popular = 0
    case nowPlaying = 1
    case upcoming = 2
    case topRated = 3
    
    var text: String {
        switch self {
        case .popular:
            String(localized: "Popular")
        case .nowPlaying:
            String(localized: "Now playing")
        case .upcoming:
            String(localized: "Upcoming")
        case .topRated:
            String(localized: "Top rated")
        }
    }
    
    static var tabbable: [MovieCategory] {
        [.nowPlaying, .upcoming, .topRated]
    }
}

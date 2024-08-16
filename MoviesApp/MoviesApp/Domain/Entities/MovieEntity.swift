//
//  MovieEntity.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

typealias MoviesList = [MovieEntity]

struct PageableMoviesList {
    var movies: MoviesList
    let hasNextPage: Bool
}

struct MovieEntity {
    let id: Int
    let title: String
    let description: String?
    let poster: URL?
    let releaseDate: Date?
    let voteAverage: String?
    let genres: GenreList?
    
    var releaseYear: Int? {
        guard let releaseDate else { return nil }
        let calendar = Calendar.current
        return calendar.component(.year, from: releaseDate)
    }
}

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
    let posterPath: String?
    let releaseDate: Date?
    let voteAverage: Double?
    let genres: GenreList?
}

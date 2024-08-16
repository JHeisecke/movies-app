//
//  MoviesResponse.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

// MARK: - MoviesResponse

struct MoviesResponse: Codable {
    let dates: AvailableDates?
    let page: Int?
    let results: [MovieResponse]
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates

struct AvailableDates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result

struct MovieResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - As Entity

extension MoviesResponse {
    func asEntity() -> PageableMoviesList {
        let movies: MoviesList = self.asEntity()
        let hasMorePages = totalPages != nil && page ?? 0 < totalPages ?? 0
        return PageableMoviesList(movies: movies, hasNextPage: hasMorePages)
    }
    
    func asEntity() -> MoviesList {
        var movies: MoviesList = []
        for response in results {
            guard let movie = response.asEntity() else { break }
            movies.append(movie)
        }
        return movies
    }
}

extension MovieResponse {
    func asEntity() -> MovieEntity? {
        let releaseData = DateFormatter().stringToDate_yyyyMMdd(releaseDate)
        let voteAverage = voteAverage != nil ? String(floor(10 * self.voteAverage!) / 10) : nil
        let poster = URL(string: "https://image.tmdb.org/t/p/original/\(posterPath ?? "")")
        return .init(id: id, title: title ?? String(localized: "Untitled Project"), description: overview, poster: poster, releaseDate: releaseData, voteAverage: voteAverage, genres: nil)
    }
}

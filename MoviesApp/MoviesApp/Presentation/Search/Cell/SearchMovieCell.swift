//
//  SearchMovieCell.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import SwiftUI

struct SearchMovieCell: View {
    
    let movie: MovieEntity
    
    var onTapGesture: () -> Void
    
    var body: some View {
        HStack(alignment: .top) {
            MovieCellView(name: movie.title, imageURL: movie.poster, size: .small)
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title)
                    .lineLimit(1)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.vertical, 5)
                if let voteAverage = movie.voteAverage {
                    VoteAverageView(voteAverage: voteAverage)
                }
                if let releaseYear = movie.releaseYear {
                    ReleaseYearView(releaseYear: releaseYear)
                }
            }
        }
        .onTapGesture {
            onTapGesture()
        }
    }
}

#Preview {
    ZStack {
        Color.skyCaptain
        SearchMovieCell(movie: MovieEntity(id: 10, title: "Black Panther", description: "Description", poster: URL(string: "https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg"), releaseDate: Date(), voteAverage: "7.9", genres: nil)) {
            
        }
    }
}

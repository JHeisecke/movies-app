//
//  SearchView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Search")
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                SearchBar(text: $viewModel.searchText) {
                    
                } cancel: {
                    
                }
                ScrollView() {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.searchedMovies, id: \.id) { movie in
                            SearchMovieCell(movie: MovieEntity(id: 10, title: "Black Panther", description: "Description", poster: URL(string: "https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg"), releaseDate: Date(), voteAverage: "7.9", genres: nil)) {
                                
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.skyCaptain)
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}

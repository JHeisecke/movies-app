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
                SearchBar(text: $viewModel.searchText)
                switch viewModel.searchStatus {
                case .loading:
                    Color.clear
                case .empty:
                    emptyView
                case .data(let movies):
                    scrollView(movies)
                }
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.skyCaptain)
        }
    }
    
    func scrollView(_ movies: MoviesList) -> some View {
        ScrollView() {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(movies, id: \.id) { movie in
                    movieDetailLink(movie)
                }
            }
        }
        .scrollIndicators(.never)
    }
    
    // MARK: - Empty State
    
    var emptyView: some View {
        ContentUnavailableView("We are sorry, no movie was found with that name", systemImage: "magnifyingglass", description: Text("Find movies by title"))
    }
    
    // MARK: - Navigation
    
    func movieDetailLink(_ movie: MovieEntity) -> some View {
        NavigationLink {
            MovieDetailView(viewModel: viewModel.movieDetailViewModel(movie: movie))
        } label: {
            SearchMovieCell(movie: movie)
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(searchUseCase: SearchMoviesUseCase(moviesRepository: MoviesRepository()), getVideoUseCase: GetVideoUseCase(moviesRepository: MoviesRepository()), debouncer: Debouncer(delay: 2)))
}

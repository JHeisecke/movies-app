//
//  WatchlistView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import SwiftUI

struct WatchlistView: View {
    
    @StateObject var viewModel: WatchlistViewModel
    
    var body: some View {
        VStack {
            Text("Search")
                .frame(maxWidth: .infinity)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            switch viewModel.movies {
            case .loading:
                Color.clear
            case .empty:
                emptyView
            case .data(let movies):
                List {
                    ForEach(movies, id: \.id) { movie in
                        movieDetailLink(movie)
                            .listRowSeparator(.hidden, edges: .all)
                    }
                }
                .listStyle(.plain)
            }
        }
        .background(.skyCaptain)
    }
    
    // MARK: - Empty State
    
    var emptyView: some View {
        ContentUnavailableView("You haven't saved any movie Yet", systemImage: "film.stack", description: Text("Try searching movies and saving them!"))
            .foregroundStyle(.white)
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
    NavigationStack {
        WatchlistView(viewModel: WatchlistViewModel(getVideoUseCase: GetVideoUseCase(moviesRepository: MoviesRepository())))
    }
}

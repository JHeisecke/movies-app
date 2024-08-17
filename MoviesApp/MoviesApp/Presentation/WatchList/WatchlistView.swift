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
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    Task {
                                        await viewModel.removeFromWatchlist(movie)
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                            }
                    }
                    .listStyle(.plain)
                    .background(.skyCaptain)
                }
            case .error:
                errorView
            }
        }
        .background(.skyCaptain)
        .task {
            await viewModel.getAllWatchlistMovies()
        }
    }
    
    // MARK: - States
    
    var errorView: some View {
        ContentUnavailableView("An error occured!", systemImage: "figure.fall", description: Text("Come back later!"))
            .foregroundStyle(.white)
    }
    
    var emptyView: some View {
        ContentUnavailableView("You haven't saved any movie yet", systemImage: "film.stack", description: Text("Try searching movies and saving them!"))
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
        WatchlistView(viewModel: WatchlistViewModel(getVideoUseCase: GetVideoUseCase(moviesRepository: MoviesRepository()), getWatchlistMoviesUseCase: GetAllMoviesFromWatchlistUseCase(watchlistRepository: WatchlistRepository()), saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCase(watchlistRepository: WatchlistRepository()), removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCase(watchlistRepository: WatchlistRepository()), getMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCase(watchlistRepository: WatchlistRepository())))
    }
}

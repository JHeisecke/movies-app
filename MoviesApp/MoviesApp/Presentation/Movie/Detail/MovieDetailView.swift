//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import SwiftUI
import YouTubePlayerKit

struct MovieDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: MovieDetailViewModel
    @StateObject private var youTubePlayer: YouTubePlayer = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                detail
                loading
            }
            .background(Color.skyCaptain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Detail")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            if viewModel.isBookmarked {
                                await viewModel.removeFromWatchlist()
                            } else {
                                await viewModel.saveOnWatchlist()
                            }
                        }
                    } label: {
                        Image(systemName: viewModel.isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .background(Color.skyCaptain)
        .task {
            youTubePlayer.configuration = .init(autoPlay: false)
            await viewModel.getVideo()
            youTubePlayer.source = .video(id: viewModel.video?.key ?? "")
        }
        .task(priority: .background) {
            await viewModel.checkIfMovieIsOnWatchlist()
        }
    }
    
    var loading: some View {
        Group {
            switch viewModel.bookmarkState {
            case .loading:
                rectangle
                    .overlay(alignment: .center) {
                        VStack {
                            ProgressView()
                            Text("Loading")
                        }
                    }
            case .error(let saved):
                rectangle
                    .overlay(alignment: .center) {
                        VStack {
                            Image(systemName: "xmark")
                            Text("Error")
                        }
                    }
            case .done(let saved):
                rectangle
                    .overlay(alignment: .center) {
                        VStack {
                            Image(systemName: "checkmark")
                            Text("Error")
                        }
                    }
            case .none:
                Color.clear
            }
        }
    }
    
    var rectangle: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 100, height: 200)
            .foregroundStyle(.black.opacity(0.6))
    }
    
    var detail: some View {
        ScrollView {
            VStack {
                YouTubePlayerView(self.youTubePlayer) { state in
                    switch state {
                    case .idle:
                        ProgressView()
                    case .ready:
                        EmptyView()
                    case .error:
                        Text(verbatim: "YouTube player couldn't be loaded")
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: Constants.trailerHeight)
                .overlay(alignment: .bottomLeading) {
                    HStack(alignment: .center) {
                        MovieCellView(name: viewModel.movie.title, imageURL: viewModel.movie.poster, size: .small)
                            .padding(.leading, 30)
                        Text(viewModel.movie.title)
                            .lineLimit(4)
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.top)
                    }
                    .offset(y: Constants.trailerHeight/2)
                    .padding(.bottom)
                }
                .padding(.bottom, Constants.trailerHeight/2)
                HStack {
                    if let year = viewModel.movie.releaseYear {
                        ReleaseYearView(releaseYear: year, color: .spanishGray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.movie.description ?? "")
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
            }
        }
        .scrollIndicators(.never)
    }
    
    // MARK: - Types
    
    struct Constants {
        static let trailerHeight: CGFloat = 210
    }
}

#Preview {
    MovieDetailView(viewModel: MovieDetailViewModel(movie: MovieEntity(id: 10, title: "Black Panther", description: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.", poster: URL(string: "https://image.tmdb.org/t/p/original/xYduFGuch9OwbCOEUiamml18ZoB.jpg"), releaseDate: Date(), voteAverage: "7.9", genres: nil), getVideoUseCase: GetVideoUseCase(moviesRepository: MoviesRepository()), removeMovieFromWatchlistUseCase: RemoveMovieFromWatchlistUseCase(watchlistRepository: WatchlistRepository()), saveMovieOnWatchlistUseCase: SaveMovieOnWatchlistUseCase(watchlistRepository: WatchlistRepository()), getMovieFromWatchlistUseCase: GetMovieFromWatchlistUseCase(watchlistRepository: WatchlistRepository())))
}

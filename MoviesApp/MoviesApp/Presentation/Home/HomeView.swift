//
//  HomeView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    let columns: [GridItem] = [
        GridItem(.fixed(PosterSize.small.width), spacing: 15, alignment: .center),
        GridItem(.fixed(PosterSize.small.width), spacing: 15, alignment: .center),
        GridItem(.fixed(PosterSize.small.width), spacing: 15, alignment: .center)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 25) {
                Text("What do you want to watch?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, Constants.padding)
                    .foregroundStyle(.white)
                popularSection
                categoriesSection
            }
        }
        .background(Color.skyCaptain)
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            Task {
                await viewModel.onAppear()
            }
        }
    }
    
    var popularSection: some View {
        VStack(alignment: .leading) {
            Text(MovieCategory.popular.text)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, Constants.padding)
                .foregroundStyle(.white)
            switch viewModel.popularMovies {
            case .loading:
                HStack {
                    ForEach(0..<6, id: \.self) { _ in
                        MovieCellView(name:"", path: nil, size: PosterSize.medium)
                    }
                }
            case .data(let result):
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(result.movies, id: \.id) { movie in
                            MovieCellView(name: movie.title, path: movie.posterPath, size: PosterSize.medium)
                        }
                        Color.clear
                            .task {
                                await viewModel.getNextPage()
                            }
                    }
                }
                .contentMargins(.leading, Constants.padding)
            case .error:
                Text("An error occured :(")
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
            }
        }
    }
    
    var categoriesSection: some View {
        VStack {
            CategoriesView(onTabChange: viewModel.categoryChange)
            LazyVGrid(columns: columns, content: {
                ForEach(viewModel.categorySelectedMovies, id: \.id) { movie in
                    MovieCellView(name: movie.title, path: movie.posterPath, size: PosterSize.small)
                }
            })
            .padding(.horizontal, Constants.padding)
        }
        .padding(.vertical, Constants.padding)
    }
    
    // MARK: - Constants
    
    struct Constants {
        static let padding: CGFloat = 15
    }
}

#Preview {
    HomeView(viewModel: .init(getPopularUseCase: GetPopularMoviesUseCase(moviesRepository: MoviesRepository()), getUpcomingUseCase: GetUpcomingMoviesUseCase(moviesRepository: MoviesRepository()), getTopRatedUseCase: GetTopRatedMoviesUseCase(moviesRepository: MoviesRepository()), getNowPlayingUseCase: GetNowPlayingMoviesUseCase(moviesRepository: MoviesRepository())))
}

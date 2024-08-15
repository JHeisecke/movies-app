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
        GridItem(.fixed(Constants.subCategoryPosterWidth), spacing: 15, alignment: .center),
        GridItem(.fixed(Constants.subCategoryPosterWidth), spacing: 15, alignment: .center),
        GridItem(.fixed(Constants.subCategoryPosterWidth), spacing: 15, alignment: .center)
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
    }
    
    var popularSection: some View {
        VStack(alignment: .leading) {
            Text(MovieCategory.popular.text)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, Constants.padding)
                .foregroundStyle(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<10, id: \.self) { _ in
                        MovieCellView(name: "Black Panther", url: URL(string: "https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg"), width: Constants.popularPosterWidth)
                    }
                }
            }
            .contentMargins(.leading, Constants.padding)
        }
    }
    
    var categoriesSection: some View {
        VStack {
            CategoriesView(onTabChange: viewModel.categoryChange)
            LazyVGrid(columns: columns, content: {
                ForEach(0..<6, id: \.self) { _ in
                    MovieCellView(name: "Black Panther", url: URL(string: "https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg"), width: Constants.subCategoryPosterWidth)
                }
            })
            .padding(.horizontal, Constants.padding)
        }
        .padding(.vertical, Constants.padding)
    }
    
    // MARK: - Constants
    
    struct Constants {
        static let padding: CGFloat = 15
        static let popularPosterWidth: CGFloat = 200
        static let subCategoryPosterWidth: CGFloat = 110
    }
}

#Preview {
    HomeView(viewModel: .init())
}

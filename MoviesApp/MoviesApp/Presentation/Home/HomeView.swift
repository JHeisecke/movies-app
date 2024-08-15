//
//  HomeView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    let horizontalPadding: CGFloat = 15
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                Text("What do you want to watch?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, horizontalPadding)
                    .foregroundStyle(.white)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<10, id: \.self) { _ in
                            MovieCellView(name: "Black Panther dsjad ldsakd ldka", url: URL(string: "https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg"), width: 144)
                        }
                    }
                }
                .contentMargins(.leading, horizontalPadding)
            }
        }
        .background(Color.skyCaptain)
    }
}

#Preview {
    HomeView(viewModel: .init())
}

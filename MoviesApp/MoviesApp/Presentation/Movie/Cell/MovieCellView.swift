//
//  MovieCellView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct MovieCellView: View {
    
    var name: String
    var url: URL?
    
    let width: CGFloat
    let ratio = 1.44
    
    var height: CGFloat {
        width*ratio
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(width: width, height: height)
            default:
                Image("posterPlaceholder")
                    .resizable()
                    .frame(width: width, height: height)
                    .overlay(alignment: .top) {
                        Text(name)
                            .font(.title)
                            .minimumScaleFactor(0.1)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .italic()
                            .padding()
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ZStack {
        Color.skyCaptain
        VStack(spacing: 10) {
            MovieCellView(name: "Black Panther", url: URL(string: "https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg"), width: 144)
            MovieCellView(name: "Black Panther dsjad ldsakd ldka", url: URL(string: "https://www.washingtonpost.com/graphics/2019/entertainment/osfcar-nominees-movie-poster-design/img/black-panther-web.jpg"), width: 95)
        }
    }
}

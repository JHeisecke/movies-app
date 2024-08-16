//
//  MovieCellView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI
import Kingfisher

struct MovieCellView: View {
    
    var name: String
    var imageURL: URL?
    
    let size: PosterSize
    let ratio = 1.44
    
    var height: CGFloat {
        size.width*ratio
    }
    
    var body: some View {
        KFImage(imageURL)
            .placeholder {
                placeholder
            }
            .retry(maxCount: 3, interval: .seconds(5))
            .cancelOnDisappear(true)
            .cacheOriginalImage()
            .resizable()
            .frame(width: size.width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    var placeholder: some View {
        Image("posterPlaceholder")
            .resizable()
            .frame(width: size.width, height: height)
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

#Preview {
    ZStack {
        Color.skyCaptain
        VStack(spacing: 10) {
            MovieCellView(name: "Black Panther", imageURL: URL(string: "https://www.washingtonpost.com/graphics/2019/entertainment/oscar-nominees-movie-poster-design/img/black-panther-web.jpg"), size: PosterSize.medium)
        }
    }
}

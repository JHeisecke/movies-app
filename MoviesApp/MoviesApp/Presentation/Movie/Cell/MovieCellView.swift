//
//  MovieCellView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct MovieCellView: View {
    
    var name: String
    var path: String?
    
    let size: PosterSize
    let ratio = 1.44
    
    var height: CGFloat {
        size.width*ratio
    }
    
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)/\(path ?? "")")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(width: size.width, height: height)
            default:
                placeholder
            }
        }
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
            MovieCellView(name: "Black Panther", path: "/6yK9hmS641NMwRkR1wWAALWI34t.jpg", size: PosterSize.medium)
        }
    }
}

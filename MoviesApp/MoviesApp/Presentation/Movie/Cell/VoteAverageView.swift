//
//  VoteAverageView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import SwiftUI

struct VoteAverageView: View {
    
    let voteAverage: String
    
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "star")
            Text(voteAverage)
        }
        .fontWeight(.semibold)
        .foregroundStyle(.orangeStar)
    }
}

#Preview {
    VStack {
        VoteAverageView(voteAverage: "7.9")
    }
}

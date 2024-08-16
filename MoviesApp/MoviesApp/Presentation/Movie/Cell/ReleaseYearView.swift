//
//  ReleaseYearView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import SwiftUI

struct ReleaseYearView: View {
    
    let releaseYear: Int
    var color: Color = .white
    
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "calendar")
            Text(verbatim: "\(releaseYear)")
        }
        .foregroundStyle(color)
    }
}

#Preview {
    VStack {
        ReleaseYearView(releaseYear: 2019, color: Color.white)
        ReleaseYearView(releaseYear: 2019, color: Color.spanishGray)
    }
    .background(Color.skyCaptain)
}

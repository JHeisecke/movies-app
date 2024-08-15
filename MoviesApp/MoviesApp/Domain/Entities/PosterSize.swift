//
//  PosterSize.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

enum PosterSize: String {
    case small = "w92"
    case medium = "w185"
    
    var width: CGFloat {
        switch self {
        case .small:
            110
        case .medium:
            200
        }
    }
}

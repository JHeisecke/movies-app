//
//  MovieVideoSite.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

struct MovieVideoEntity {
    let id: String
    let name: String
    let site: VideoSite
    let videoType: VideoType
    let key: String
}

enum VideoSite: String, Codable {
    case youTube = "YouTube"
}

enum VideoType: String, Codable {
    case behindTheScenes = "Behind the Scenes"
    case clip = "Clip"
    case featurette = "Featurette"
    case teaser = "Teaser"
    case trailer = "Trailer"
}

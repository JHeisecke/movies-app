//
//  MovieVideosResponse.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

// MARK: - VideosResponse

struct MovieVideosResponse: Codable {
    let id: Int?
    let results: [VideoResponse]?
}

// MARK: - Result

struct VideoResponse: Codable {
    let id: String
    let iso639_1: String?
    let iso3166_1: String?
    let name, key: String
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

// MARK: - As Entity

extension MovieVideosResponse {
    func asEntity(type: VideoType, site: VideoSite) -> MovieVideoEntity? {
        guard let video = self.results?.first(where: { $0.type == type.rawValue && $0.site == site.rawValue }) else { return nil }
        return MovieVideoEntity(id: video.id, name: video.name, site: site, videoType: type, key: video.key)
    }
}

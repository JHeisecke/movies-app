//
//  GetVideoUseCase.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol GetVideoUseCaseProtocol {
    func get(id: Int, type: VideoType, site: VideoSite) async throws -> MovieVideoEntity
}

struct GetVideoUseCase: GetVideoUseCaseProtocol {
    
    private let moviesRepository: MoviesRepositoryProtocol

    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }

    func get(id: Int, type: VideoType, site: VideoSite) async throws -> MovieVideoEntity {
        return try await moviesRepository.getVideo(ofMovie: id, type: type, site: site)
    }
}

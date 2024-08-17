//
//  WatchlistRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

protocol WatchlistRepositoryProtocol {
    func store(movie: MovieEntity) async -> Bool
    func get(by id: Int) async throws -> MovieEntity?
    func getAll() async throws -> MoviesList
}

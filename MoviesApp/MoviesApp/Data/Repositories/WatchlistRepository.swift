//
//  WatchlistRepository.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation
import CoreData

struct WatchlistRepository: WatchlistRepositoryProtocol {
    
    private var coreDataStack: CoreDataStack = .init(.watchlist)
    
    func store(movie: MovieEntity) async -> Bool {
        let context = coreDataStack.context
        let movieModel = MovieModel(context: context)
        movieModel.id = Int64(movie.id)
        movieModel.title = movie.title
        movieModel.movieDescription = movie.description
        movieModel.poster = movie.poster?.absoluteString
        movieModel.releaseDate = movie.releaseDate
        movieModel.voteAverage = movie.voteAverage
        movieModel.genres = movie.genres as? NSObject
        
        return await context.perform {
            coreDataStack.saveContext()
            return true
        }
    }
    
    func get(by id: Int) async throws -> MovieEntity? {
        let context = coreDataStack.context
        let fetchRequest: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        return try await context.perform {
            let results = try fetchRequest.execute()
            return results.first?.asEntity()
        }
    }
    
    func getAll() async throws -> MoviesList {
        let context = coreDataStack.context
        let fetchRequest: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        
        return try await context.perform {
            let results = try fetchRequest.execute()
            return results.map { $0.asEntity() }
        }
    }
}

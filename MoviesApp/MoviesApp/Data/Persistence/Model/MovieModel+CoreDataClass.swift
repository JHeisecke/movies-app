//
//  MovieModel+CoreDataClass.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//
//

import Foundation
import CoreData


public class MovieModel: NSManagedObject {

}

extension MovieModel {
    func asEntity() -> MovieEntity {
        return MovieEntity(
            id: Int(self.id),
            title: self.title ?? "",
            description: self.movieDescription,
            poster: URL(string: self.poster ?? ""),
            releaseDate: self.releaseDate,
            voteAverage: self.voteAverage,
            genres: nil
        )
    }
}


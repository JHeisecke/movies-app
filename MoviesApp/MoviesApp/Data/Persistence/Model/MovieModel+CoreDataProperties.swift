//
//  MovieModel+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//
//

import Foundation
import CoreData


extension MovieModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieModel> {
        return NSFetchRequest<MovieModel>(entityName: "MovieModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var movieDescription: String?
    @NSManaged public var poster: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var voteAverage: String?

}

extension MovieModel : Identifiable {

}

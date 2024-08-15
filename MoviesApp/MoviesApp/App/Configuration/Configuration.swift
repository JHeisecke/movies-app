//
//  Configuration.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

enum Configuration {
    
    private enum Keys {
        static let tmdbApiKey = "TMDB_API_KEY"
        static let tmdbAccessToken = "TMBD_API_READ_ACCESS_TOKEN"
    }
    
    private static var infoDictionary: [String: Any] {
        Bundle.main.infoDictionary ?? [:]
    }
    
    static var tmdbApiKey: String {
        infoDictionary[Keys.tmdbApiKey] as! String
    }
    
    static var tmdbAccessToken: String {
        infoDictionary[Keys.tmdbAccessToken] as! String
    }
}

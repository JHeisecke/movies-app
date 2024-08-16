//
//  MoviesEndpoint.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

enum MoviesEndpoint {
    case getPopular(language: String, page: String)
    case getTopRated(language: String, page: String)
    case getNowPlaying(language: String, page: String)
    case getUpcoming(language: String, page: String)
    case searchMovie(query: String)
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getPopular:
            "/3/movie/popular"        
        case .getTopRated:
            "/3/movie/top_rated"
        case .getNowPlaying:
            "/3/movie/now_playing"
        case .getUpcoming:
            "/3/movie/now_playing"        
        case .searchMovie:
            "/3/search/movie"
        }
    }
    
    var queryParams: [URLQueryItem]? {
        switch self {
        case .getPopular(let language, let page):
            [URLQueryItem(name: "language", value: language), URLQueryItem(name: "page", value: page)]
        case .getTopRated(let language, let page):
            [URLQueryItem(name: "language", value: language), URLQueryItem(name: "page", value: page)]
        case .getNowPlaying(let language, let page):
            [URLQueryItem(name: "language", value: language), URLQueryItem(name: "page", value: page)]
        case .getUpcoming(let language, let page):
            [URLQueryItem(name: "language", value: language), URLQueryItem(name: "page", value: page)]
        case .searchMovie(let query):
            [URLQueryItem(name: "query", value: query)]
        }
    }
    
    var mockFile: String? {
        switch self {
        case .getPopular:
            "popular"
        case .getTopRated:
            "top-rated"
        case .getNowPlaying:
            "now-playing"
        case .getUpcoming:
            "upcoming"
        case .searchMovie:
            "popular"
        }
    }
}

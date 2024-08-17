//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(movieRepository: MoviesRepository(), watchlistRepository: WatchlistRepository()))
                .preferredColorScheme(.dark)
        }
    }
}

//
//  MainView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    
    let viewModel: MainViewModel
    
    @State private var activeTab: Tab = .home
    
    var body: some View {
        NavigationStack {
            TabView(selection: $activeTab,
                    content:  {
                HomeView(viewModel: viewModel.homeViewModel)
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(Tab.home)
                SearchView(viewModel: viewModel.searchViewModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(Tab.search)
                WatchlistView(viewModel: viewModel.watchlistViewModel)
                    .tabItem {
                        Image(systemName: "bookmark")
                    }
                    .tag(Tab.watchlist)
            })
            .background(Color.skyCaptain)
            
        }
        .onAppear(perform: {
            UITabBar.appearance().backgroundColor = UIColor.indianInk
            UITabBar.appearance().unselectedItemTintColor = UIColor.midnightGrey
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            
        })
    }
    
    // MARK: - Types
    
    enum Tab {
        case home
        case search
        case watchlist
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}

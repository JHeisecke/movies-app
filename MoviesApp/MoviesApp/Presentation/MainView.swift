//
//  MainView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    
    @State private var activeTab: Tab = .home
    
    var body: some View {
        NavigationStack {
            TabView(selection: $activeTab,
                    content:  {
                HomeView(viewModel: .init())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(Tab.home)
                Text("Search")
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(Tab.search)
                Text("Watch list")
                    .tabItem {
                        Label("Watch list", systemImage: "bookmark")
                    }
                    .tag(Tab.watchlist)
            })
        }
    }
    
    // MARK: - Types
    
    enum Tab {
        case home
        case search
        case watchlist
    }
}

#Preview {
    MainView()
}

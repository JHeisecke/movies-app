//
//  HomeView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init())
}

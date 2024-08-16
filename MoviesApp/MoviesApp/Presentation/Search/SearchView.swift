//
//  SearchView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
//            SearchBar(text: $searchText) {
//                
//            } cancel: {
//                
//            }
            ScrollView {
                LazyVStack {
                    
                }
            }
        }
    }
}

#Preview {
    SearchView()
}

//
//  CategoriesView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct CategoriesView: View {
    @State var selectedTab: MovieCategory = .nowPlaying
    @Namespace var namespace
    
    var onTabChange: (MovieCategory) -> Void
    
    var body: some View {
        HStack {
            ForEach(MovieCategory.tabbable) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace, onTabChange: onTabChange)
                    .padding()
            }
        }
    }
    
    private struct TabButton: View {
        let tab: MovieCategory
        @Binding var selectedTab: MovieCategory
        var namespace: Namespace.ID

        var onTabChange: (MovieCategory) -> Void
        
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
                    onTabChange(selectedTab)
                }
            } label: {
                VStack {
                    Text(tab.text)
                        .font(.callout)
                        .foregroundColor(isSelected ? .init(white: 0.9) : .gray)
                        .offset(y: -5)
                    if isSelected {
                        Rectangle()
                            .frame(height: 4)
                            .foregroundStyle(Color.indianInk)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                            .animation(.default, value: selectedTab)
                    } else {
                        Rectangle()
                            .frame(height: 4)
                            .hidden()
                    }
                }
            }
            .buttonStyle(.plain)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}

#Preview {
    ZStack {
        Color.skyCaptain
        CategoriesView(onTabChange: { _ in})
    }
}

//
//  CategoriesView.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct CategoriesView: View {
    @State var selectedTab: Tab = .nowPlaying
    @Namespace var namespace
    
    var onTabChange: (Tab) -> Void
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                    .padding()
            }
        }
    }
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
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
    
    // MARK: - Types
    
    enum Tab: Int, Identifiable, CaseIterable {
        internal var id: Int { rawValue }
        
        case nowPlaying = 0
        case upcoming = 1
        case topRated = 2
        
        var text: String {
            switch self {
            case .nowPlaying:
                String(localized: "Now playing")
            case .upcoming:
                String(localized: "Upcoming")
            case .topRated:
                String(localized: "Top rated")
            }
        }
    }
}

#Preview {
    ZStack {
        Color.skyCaptain
        CategoriesView(onTabChange: { _ in})
    }
}

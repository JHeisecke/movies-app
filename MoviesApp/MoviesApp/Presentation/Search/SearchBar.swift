//
//  SearchBar.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State var showCancelButton = false
    @FocusState private var isFocused: Bool
    
    let changeText: () -> Void
    let cancel: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            HStack {
                TextField("Search", text: $text, prompt: Text("Search").foregroundColor(Color.midnightGrey))
                    .foregroundColor(Color.midnightGrey)
                    .frame(height: 38)
                    .focused($isFocused)
                    .onTapGesture {
                        withAnimation {
                            showCancelButton = true
                        }
                    }
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.midnightGrey)
            }
            .padding(.leading, 25)
            .padding(.trailing, 18)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background(Color.indianInk)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            if showCancelButton {
                Button("Cancel", action: {
                    text = ""
                    cancel()
                    isFocused = false
                    withAnimation {
                        showCancelButton = false
                    }
                })
                .tint(Color.midnightGrey)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.skyCaptain
        SearchBar(text: .constant(""), showCancelButton: false) {
            
        } cancel: {
            
        }
        .padding()
    }
}

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

    var body: some View {
        HStack(alignment: .center) {
            HStack {
                TextField("Search", text: $text, prompt: Text("Search").foregroundColor(Color.midnightGrey))
                    .foregroundColor(Color.midnightGrey)
                    .frame(height: 38)
                    .focused($isFocused)
                    .onChange(of: isFocused) { oldValue, newValue in
                        if newValue {
                            withAnimation {
                                showCancelButton = true
                            }
                        } else  if !newValue && text.isEmpty {
                            withAnimation {
                                showCancelButton = false
                            }
                        }
                    }
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.midnightGrey)
            }
            .padding(.leading, 25)
            .padding(.trailing, 18)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .background(Color.indianInk)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .onTapGesture {
                isFocused = true
            }
            if showCancelButton {
                Button("Cancel", action: {
                    text = ""
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
        SearchBar(text: .constant(""), showCancelButton: false)
        .padding()
    }
}
